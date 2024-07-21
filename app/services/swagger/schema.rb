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

    def schema(attrs = serializer.serializable_hash.keys)
      {
        type: 'object',
        properties: attrs.each_with_object({}) do |attr, props|
          type = attribute_types[attr.to_s]
          props[attr] = {
            type: oas_type(type),
            example: type.example,
          }
          props[attr][:enum] = defined_enums[attr.to_s].keys if respond_to?(:defined_enums) && defined_enums[attr.to_s]
          props[attr]
        end
      }
    end

    def oas_type(attr_type)
      case attr_type.type.to_s
      when 'datetime', 'text' then 'string'
      else attr_type.type
      end
    end

    def serializer
      ActiveModelSerializers::SerializableResource.new(new)
    end
  end
end
