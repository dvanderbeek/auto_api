# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField

    def self.type_for_column(column_type)
      case column_type
      when :string, :text then GraphQL::Types::String
      when :integer then GraphQL::Types::BigInt
      when :datetime then GraphQL::Types::ISO8601DateTime
      else nil
      end
    end
  end
end
