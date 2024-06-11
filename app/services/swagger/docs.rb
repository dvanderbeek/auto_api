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
        tag = klass.module_parent.name.underscore
        example = Example.new(klass).json

        if klass.available_restful_actions.include?(:show)
          show = Show.new(klass)
          paths[show.path] = show.operation
        end

        if klass.available_restful_actions.include?(:index)
          index = Index.new(klass)
          paths[index.path] = index.operation
        end
      end
    end
  end
end
