module Swagger
  class Show < Operation
    def path
      Rails.application.routes.url_helpers.send("#{table_name}_path") + '/{id}'
    end

    def operation
      {
        get: {
          summary: "Find #{table_name.titleize.singularize} by ID",
          operationId: "get#{table_name.camelize.upcase_first.singularize}",
          tags: [ tag ],
          responses: {
            '200': {
              description: 'OK',
              content: {
                'application/json': {
                  schema:,
                  example:
                }
              }
            },
            '404': {
              description: 'Not Found'
            }
          }
        }
      }
    end
  end
end
