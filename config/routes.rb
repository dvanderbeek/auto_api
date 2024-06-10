Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  (ApplicationRecord.descendants + VirtualRecord.descendants).each do |klass|
    namespace, model = klass.name.split('::')

    scope namespace.underscore do
      resources model.underscore.pluralize,
                controller: 'api',
                defaults: { model: klass.name },
                only: klass.available_restful_actions,
                as: klass.table_name
    end
  end

  get "/docs", to: "api#docs"
  mount Rswag::Ui::Engine => 'swagger'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
