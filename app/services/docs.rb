class Docs
  def self.generate
    {
      openapi: '3.1.0',
      info: {
        title: 'Figment API',
        version: '2.0.0',
        termsOfService: 'https://figment.io/staking-terms-of-use'
      },
      paths:
    }.to_json
  end

  def self.paths
    paths = {}

    (ApplicationRecord.subclasses + VirtualRecord.subclasses).each do |klass|
      serializer = ActiveModelSerializers::SerializableResource.new(klass.new)
      attrs = serializer.serializable_hash.keys

      paths["/#{klass.name.gsub('::', '/').downcase.pluralize}"] = {
        get: {
          summary: "List all #{klass.table_name.titleize}",
          responses: {
            '200': {
              description: "A list of #{klass.table_name.titleize}",
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      data: {
                        type: 'array',
                        items: {
                          type: 'object',
                          properties: attrs.each_with_object({}) do |attr, props|
                            props[attr] = { type: klass.attribute_types[attr.to_s].type.to_s }
                          end
                        }
                      }
                    },
                    example: attrs.each_with_object({}) do |attr, example|
                      example[attr] = klass.attribute_types[attr.to_s].example
                    end
                  }
                }
              }
            }
          }
        }
      }
    end

    paths
  end
end
