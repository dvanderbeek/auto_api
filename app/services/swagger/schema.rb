module Swagger
  class Schema < SimpleDelegator
    def oas_model
      name.gsub('::', '')
    end

    def path
      "#/components/schemas/#{oas_model}"
    end

    def ref
      { '$ref': path }
    end

    def schema
      {
        type: 'object',
        properties: attrs.each_with_object({}) do |attr, props|
          props[attr] = { type: oas_type(attribute_types[attr.to_s].type) }
        end
      }
    end

    def oas_type(attr_type)
      case attr_type.to_s
      when 'datetime', 'text' then 'string'
      else attr_type
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
