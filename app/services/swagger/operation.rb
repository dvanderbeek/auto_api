module Swagger
  class Operation < SimpleDelegator
    def path
      # TODO: not sure why this doesn't work with just `self`
      # NoMethodError (undefined method `to_model' for Ethereum::TransactionPayload...)
      Rails.application.routes.url_helpers.polymorphic_path(name.constantize)
    end

    def tag
      module_parent.name.underscore
    end

    def example
      Example.new(self).json
    end

    def schema
      Schema.new(self).ref
    end

    def input_schema(action)
      Schema.new(self).schema(allowed_attributes(action).keys)
    end
  end
end
