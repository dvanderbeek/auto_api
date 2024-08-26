class NameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless record.validated

    return if NameApiClient.new.valid_name?(value)

    message = options[:message] || 'is not valid according to remote api'
    record.errors.add(attribute, message)
  end
end
