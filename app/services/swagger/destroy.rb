module Swagger
  class Destroy < Operation
    def path
      "#{super}/{id}"
    end

    def operation
      {
        delete: {
          summary: "Deletes an existing #{name.demodulize.titleize}",
          operationId: "delete#{name.gsub('::', '')}",
          tags: [ tag ],
          parameters: [
            { name: 'id', in: 'path', required: true }
          ],
          responses: {
            '204': {
              description: 'No Content'
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
