class Sale < ApplicationRecord
  validates :unit_price_cents, presence: true, numericality: { only_integer: true }
end
