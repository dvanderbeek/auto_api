module Swagger
  class Operation < SimpleDelegator
    def tag
      module_parent.name.underscore
    end

    def example
      Example.new(self).json
    end

    def schema
      Schema.new(self).ref
    end
  end
end
