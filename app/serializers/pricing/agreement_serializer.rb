module Pricing
  class AgreementSerializer < ActiveModel::Serializer
    attributes :id, :name, :effective_fee_percentage
    has_many :fee_splits
  end
end
