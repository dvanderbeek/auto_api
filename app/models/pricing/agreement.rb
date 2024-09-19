class Pricing::Agreement < ApplicationRecord
  has_many :fee_splits

  attribute :fee_splits
end
