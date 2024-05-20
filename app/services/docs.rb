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
    }.to_yaml
  end

  def self.paths
    paths = {}

    ApplicationRecord.subclasses.each do |klass|
      serializer = ActiveModelSerializers::SerializableResource.new(klass.example)
      attrs = serializer.serializable_hash.keys

      paths[klass.table_name] = {
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
                          properties: attrs.each_with_object({}) { |attr, props| props[attr] = klass.type_for_attribute(attr).type.to_s }
                        }
                      }
                    },
                    example: JSON.parse(serializer.to_json)
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
