class ModelSchema < SimpleDelegator
  def schema
    {
      type: 'object',
      properties: attrs.each_with_object({}) do |attr, props|
        props[attr] = { type: attribute_types[attr.to_s].type.to_s }
      end
    }
  end

  def serializer
    ActiveModelSerializers::SerializableResource.new(new)
  end

  def attrs
    serializer.serializable_hash.keys
  end
end
