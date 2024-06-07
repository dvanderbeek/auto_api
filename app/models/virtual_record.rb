class VirtualRecord < ActiveModelSerializers::Model
  include ActiveModel::Model
  include ActiveModel::Attributes
  include RestfulActions

  def self.table_name
    name.gsub('::', '').pluralize.underscore
  end

  def self.permitted_attributes
    attribute_names - unpermitted_attributes
  end

  def self.unpermitted_attributes
    %w[id created_at updated_at]
  end

  def self.example
    new(self::Attrs.valid)
  rescue NameError
    new()
  end

  def self.setup_complete?
    self::Attrs
    "#{name}Serializer".constantize
    return true
  rescue NameError
    false
  end
end
