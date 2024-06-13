module Swagger
  class Update < Operation
    def path
      "#{super}/{id}"
    end

    def operation
      {
        patch: {
          summary: "Update an existing #{name.demodulize.titleize}",
          operationId: "update#{name.gsub('::', '')}",
          tags: [ tag ],
          parameters: [
            { name: 'id', in: 'path', required: true }
          ],
          requestBody: {
            content: {
              'application/json': {
                schema: input_schema(:update)
              }
            }
          },
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
