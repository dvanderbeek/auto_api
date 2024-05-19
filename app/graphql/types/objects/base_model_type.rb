module Types
  module Objects
    class BaseModelType < Types::BaseObject
      def self.type_for_column(column_type)
        case column_type
        when :string, :text then GraphQL::Types::String
        when :integer then GraphQL::Types::BigInt
        when :datetime then GraphQL::Types::ISO8601DateTime
        else nil
        end
      end

      def self.create_type(model)
        Class.new(Types::BaseObject) do
          graphql_name "#{model.name.gsub('::', '')}Type"
          description "A dynamically generated type for #{name}"

          # TODO: Base this on serializer, share with REST API responses
          model.columns.each do |column|
            field column.name.to_sym, type_for_column(column.type), null: column.null
          end
        end
      end
    end
  end
end
