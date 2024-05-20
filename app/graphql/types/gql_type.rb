module Types
  class GqlType
    attr_reader :type

    def initialize(type)
      @type = type
    end

    def to_gql
      case type
      when :string, :text then GraphQL::Types::String
      when :integer then GraphQL::Types::BigInt
      when :datetime then GraphQL::Types::ISO8601DateTime
      end
    end
  end
end
