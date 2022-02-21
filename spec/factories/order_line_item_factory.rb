FactoryBot.define do
  factory :order_line_item do
    order
    sale
    unit_price_cents { rand(99..999) }
    paid_price_cents { rand(99..999) }
  end
end
