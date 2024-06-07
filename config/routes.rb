Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # TODO: Maybe add a way to register certain models instead of all ApplicationRecord descendants
  (ApplicationRecord.descendants + VirtualRecord.descendants).each do |klass|
    namespace, model = klass.name.split('::')
    only = klass.available_restful_actions || [:index, :show, :create, :update, :destroy]

    scope namespace.underscore do
      resources model.underscore.pluralize, controller: 'api', defaults: { model: klass.name }, only:
    end
  end

  get "/docs", to: "api#docs"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
