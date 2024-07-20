module Swagger
  class Show < Operation
    def path
      "#{super}/{id}"
    end

    def operation
      {
        get: {
          summary: "Finds an existing #{name.demodulize.titleize} by ID",
          operationId: "get#{name.gsub('::', '')}",
          tags: [ tag ],
          parameters: [
            { name: 'id', in: 'path', required: true }
          ],
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
