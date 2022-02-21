class Cart < ApplicationRecord
  belongs_to :user, optional: true

  has_many :items, class_name: 'CartItem', dependent: :destroy

  def amount_to_pay_cents
    items.map(&:price_total_cents).sum
  end
end
