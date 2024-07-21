module DeclarativeEnum
  # This `prepended` hook will merge the enum definition
  # of the prepended module into the base module to be
  # used by `prepend_if_ee` helper method.
  def prepended(base)
    base.definition.merge!(definition)
  end

  def key(new_key = nil)
    @key = new_key if new_key

    @key
  end

  def name(new_name = nil)
    @name = new_name if new_name

    @name
  end

  def attr_type(new_type = nil)
    @attr_type = new_type if new_type

    @attr_type
  end

  def description(new_description = nil)
    @description = new_description if new_description

    @description
  end

  def define(&block)
    raise LocalJumpError.new('No block given') unless block

    @definition = Builder.new(definition, block).build
  end

  # We can use this method later to apply some sanity checks
  # but for now, returning a Hash without any check is enough.
  def definition
    @definition.to_h
  end

  class Builder
    KeyCollisionError = Class.new(StandardError)

    def initialize(definition, block)
      @definition = definition
      @block = block
    end

    def build
      instance_exec(&@block)

      @definition
    end

    private

    def method_missing(name, *arguments, value: nil, description: nil, &block)
      key = name.downcase.to_sym
      raise KeyCollisionError, "'#{key}' collides with an existing enum key!" if @definition[key]

      @definition[key] = {
        value: value,
        description: description
      }
    end
  end
end
