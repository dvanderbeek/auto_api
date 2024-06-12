module Swagger
  class Show < Operation
    def path
      "#{super}/{id}"
    end

    def operation
      {
        get: {
          summary: "Find #{name.demodulize.titleize} by ID",
          operationId: "get#{name.gsub('::', '')}ById",
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
