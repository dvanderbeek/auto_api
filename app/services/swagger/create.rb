module Swagger
  class Create < Operation
    # TODO: Add input parameters
    def operation
      {
        post: {
          summary: "Create a new #{name.demodulize.titleize}",
          operationId: "create#{name.gsub('::', '::')}",
          tags: [ tag ],
          requestBody: {
            content: {
              'application/json': {
                schema: input_schema
              }
            }
          },
          responses: {
            '200': {
              description: 'OK',
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
