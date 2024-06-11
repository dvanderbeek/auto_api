module Swagger
  class Index < Operation
    def operation
      {
        get: {
          summary: "List all #{table_name.titleize}",
          operationId: "get#{table_name.camelize.upcase_first}",
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
