module Swagger
  class Index < Operation
    def operation
      {
        get: {
          summary: "List all #{name.demodulize.pluralize.titleize}",
          operationId: "get#{name.gsub('::', '')}",
          tags: [ tag ],
          responses: {
            '200': {
              description: 'OK',
              content: {
                'application/json': {
                  schema: {
                    type: 'array',
                    items: schema
                  },
                  example: [example]
                }
              }
            }
          }
        }
      }
    end
  end
end
