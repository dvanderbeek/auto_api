class Docs
  def self.generate
    {
      openapi: '3.1.0',
      info: {
        title: 'Figment API',
        version: '2.0.0',
        termsOfService: 'https://figment.io/staking-terms-of-use'
      },
      paths:,
      components: {
        schemas:
      }
    }.to_json
  end

  def self.schemas
    (ApplicationRecord.subclasses + VirtualRecord.subclasses).each_with_object({}) do |klass, schemas|
      schemas[klass.name.gsub('::', '')] = ModelSchema.new(klass).schema
    end
  end

  def self.paths
    paths = {}

    (ApplicationRecord.subclasses + VirtualRecord.subclasses).each do |klass|
      serializer = ActiveModelSerializers::SerializableResource.new(klass.new)
      attrs = serializer.serializable_hash.keys

      paths[Rails.application.routes.url_helpers.send("#{klass.table_name}_path")] = {
        get: {
          summary: "List all #{klass.table_name.titleize}",
          produces: ['application/json'],
          responses: {
            '200': {
              description: "successful operation",
              content: {
                'application/json': {
                  schema: {
                      type: 'array',
                      items: {
                        "$ref": "#/components/schemas/#{klass.name.gsub('::', '')}"
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

    end

    paths
  end
end
