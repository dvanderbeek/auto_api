module Swagger
  class Example < SimpleDelegator
    def json
      attrs.each_with_object({}) do |attr, example|
        # TODO: Need to generate example for associations (along with schema)
        example[attr] = attribute_types[attr.to_s].example if attribute_types[attr.to_s].respond_to?(:example)
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
