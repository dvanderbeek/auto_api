class Docs
  def self.generate
    {
      openapi: '3.1.0',
      info: {
        title: 'Figment API',
        version: '2.0.0',
        termsOfService: 'https://figment.io/staking-terms-of-use'
      },
      paths:
    }.to_yaml
  end

  def self.generate_example(type)
    case type
    when 'integer' then 100
    when 'string' then 'Lorem ipsum dolor sit amet, consectet'
    when 'text' then 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    when 'datetime' then Time.current.iso8601
    end
  end

  def self.paths
    paths = {}

    (ApplicationRecord.subclasses + VirtualRecord.subclasses).each do |klass|
      serializer = ActiveModelSerializers::SerializableResource.new(klass.new)
      attrs = serializer.serializable_hash.keys

      paths[klass.table_name] = {
        get: {
          summary: "List all #{klass.table_name.titleize}",
          responses: {
            '200': {
              description: "A list of #{klass.table_name.titleize}",
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      data: {
                        type: 'array',
                        items: {
                          type: 'object',
                          properties: attrs.each_with_object({}) do |attr, props|
                            props[attr] = { type: klass.attribute_types[attr.to_s].type.to_s }
                          end
                        }
                      }
                    },
                    example: attrs.each_with_object({}) do |attr, example|
                      example[attr] = generate_example(klass.attribute_types[attr.to_s].type.to_s)
                    end
                  }
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
