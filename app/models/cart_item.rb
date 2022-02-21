class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :sale

  validates :quantity, presence: true, numericality: { only_integer: true }

  def price_total_cents
    self.quantity * sale.unit_price_cents
  end
end
