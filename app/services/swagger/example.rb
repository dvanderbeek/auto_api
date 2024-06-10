module Swagger
  class Example < SimpleDelegator
    def json
      attrs.each_with_object({}) do |attr, example|
        example[attr] = attribute_types[attr.to_s].example
      end
    end

    def serializer
      ActiveModelSerializers::SerializableResource.new(new)
    end

    def attrs
      serializer.serializable_hash.keys
    end
  end
end
