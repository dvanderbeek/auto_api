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

  def self.paths
    paths = {}

    ApplicationRecord.subclasses.each do |klass|
      paths[klass.table_name] = {
        get: {
          summary: "List all #{klass.table_name.titleize}",
          responses: {
            '200': {
              description: "A list of #{klass.table_name.titleize}",
              example: ActiveModelSerializers::SerializableResource.new(klass.example).to_json
            }
          }
        }
      }
    end

    paths
  end
end
