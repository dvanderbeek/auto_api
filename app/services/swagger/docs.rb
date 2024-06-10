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
        tags:,
        components: {
          schemas:
        }
      }.to_json
    end

    # TODO: This orders the tags which controls the default sorting order in Swagger UI
    # Should build a mechanism to customize the order vs. just alphabetical
    # https://swagger.io/docs/specification/grouping-operations-with-tags/
    def self.tags
      (ApplicationRecord.subclasses + VirtualRecord.subclasses).map do |k|
        k.name.deconstantize.underscore
      end.uniq.sort.map { |name| { name: } }
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
            operationId: "get#{klass.table_name.camelize.upcase_first}",
            tags: [ klass.module_parent.name.underscore ],
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
