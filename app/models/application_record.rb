class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Defines permitted_params in API. Override for each model if necessary.
  # TODO: Add way to make this dependent on context (like User's role)
  # TODO: Hanlde params that don't map exactly to db columns
  def self.permitted_attributes
    column_names - unpermitted_attributes
  end

  def self.unpermitted_attributes
    %w[id created_at updated_at]
  end

  def self.example
    new(self::Attrs.valid) rescue new()
  end

  def self.setup_complete?
    self::Attrs
    "#{name}Serializer".constantize
    return true
  rescue NameError
    false
  end
end
