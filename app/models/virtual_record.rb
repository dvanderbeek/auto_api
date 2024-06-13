class VirtualRecord
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serialization
  include RestfulActions

  restful_actions :create

  def self.table_name
    name.gsub('::', '').pluralize.underscore
  end

  def save(*)
    valid?
  end
end
