class NameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless record.validated

    puts 'calling remote api in validation'
    message = options[:message] || 'is not valid according to remote api'
    record.errors.add(attribute, message)
  end
end
