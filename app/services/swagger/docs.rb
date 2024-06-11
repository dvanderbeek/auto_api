module Swagger
  class Docs
    def self.generate
      {
        openapi: '3.0.2',
        info: {
          title: 'Figment API',
          version: '2.0.0',
          termsOfService: 'https://figment.io/staking-terms-of-use'
        },
        paths:,
        tags:,
        components: {
          schemas:
        }
      }.to_json
    end

    # TODO: This orders the tags which controls the default sorting order in Swagger UI
    # Should build a mechanism to customize the order vs. just alphabetical
    # https://swagger.io/docs/specification/grouping-operations-with-tags/
    def self.tags
      (ApplicationRecord.subclasses + VirtualRecord.subclasses).map do |k|
        k.name.deconstantize.underscore
      end.uniq.sort.map { |name| { name: } }
    end

    def self.schemas
      (ApplicationRecord.subclasses + VirtualRecord.subclasses).each_with_object({}) do |klass, schemas|
        s = Schema.new(klass)
        schemas[s.oas_model] = s.schema
      end
    end

    def self.paths
      (ApplicationRecord.subclasses + VirtualRecord.subclasses).each_with_object({}) do |klass, paths|
        add_operation(paths, klass, Show) if klass.available_restful_actions.include?(:show)
        add_operation(paths, klass, Index) if klass.available_restful_actions.include?(:index)
        add_operation(paths, klass, Destroy) if klass.available_restful_actions.include?(:destroy)
        add_operation(paths, klass, Create) if klass.available_restful_actions.include?(:create)
        add_operation(paths, klass, Update) if klass.available_restful_actions.include?(:update)
      end
    end

    def self.add_operation(paths, klass, operation_klass)
      operation = operation_klass.new(klass)
      paths[operation.path] ||= {}
      paths[operation.path].merge! operation.operation
    end
  end
end
