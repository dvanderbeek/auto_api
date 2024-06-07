class Current < ActiveSupport::CurrentAttributes
  attribute :user

  def user=(val)
    super(val&.inquiry)
  end
end
