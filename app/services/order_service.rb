class OrderService
  
  def self.create_order(cart, user, address)
    order = Order.new(
      user: user,
      first_name: user.first_name,
      last_name: user.last_name,
      address_1: address[:address_1],
      address_2: address[:address_2],
      city: address[:city],
      state: address[:state],
      country: address[:country],
      zip: address[:zip],
    )

    cart.items.each do |item|
      item.quantity.times do
        order.items << OrderLineItem.new(
          order: order,
          sale: item.sale,
          unit_price_cents: item.sale.unit_price_cents,
          shipping_costs_cents: shipping_costs,
          paid_price_cents: item.sale.unit_price_cents + shipping_costs
        )
      end
    end

    order.save
    order
  end

  private

  def self.shipping_costs
    100
  end

end