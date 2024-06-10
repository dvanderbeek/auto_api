module Swagger
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
        schemas[klass.name.gsub('::', '')] = Schema.new(klass).schema
      end
    end

    def self.paths
      paths = {}

      (ApplicationRecord.subclasses + VirtualRecord.subclasses).each do |klass|
        paths[Rails.application.routes.url_helpers.send("#{klass.table_name}_path")] = {
          get: {
            summary: "List all #{klass.table_name.titleize}",
            responses: {
              '200': {
                description: 'OK',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        "$ref": "#/components/schemas/#{klass.name.gsub('::', '')}"
                      }
                    },
                    example: [Example.new(klass).json]
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
end
