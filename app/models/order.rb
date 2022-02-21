class Order < ApplicationRecord
  belongs_to :user

  has_many :items, class_name: 'OrderLineItem', dependent: :destroy

  def subtotal_cents
    items.map(&:unit_price_cents).sum
  end

  def total_cents
    items.map(&:paid_price_cents).sum
  end
end
