class VirtualRecord
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serialization
  include RestfulActions

  restful_actions :create

  def self.table_name
    name.gsub('::', '').pluralize.underscore
  end

  def self.permitted_attributes
    attribute_names - unpermitted_attributes
  end

  def self.unpermitted_attributes
    %w[id created_at updated_at]
  end

  def save(*)
    valid?
  end
end
