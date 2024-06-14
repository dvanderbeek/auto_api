module Swagger
  class Create < Operation
    def operation
      {
        post: {
          summary: "Create a new #{name.demodulize.titleize}",
          operationId: "create#{name.gsub('::', '')}",
          tags: [ tag ],
          requestBody: {
            content: {
              'application/json': {
                schema: input_schema(:create)
              }
            }
          },
          responses: {
            '201': {
              description: 'Created',
              content: {
                'application/json': {
                  schema: {
                    type: 'array',
                    items: schema
                  },
                  example:
                }
              }
            }
          }
        }
      }
    end
  end
end
