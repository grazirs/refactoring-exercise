class OrderLineItem < ApplicationRecord
  belongs_to :order
  belongs_to :sale

  validates :unit_price_cents, presence: true, numericality: { only_integer: true }
  validates :paid_price_cents, presence: true, numericality: { only_integer: true }
end
