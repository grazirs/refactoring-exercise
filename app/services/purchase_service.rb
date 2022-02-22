class PurchaseService
  def self.purchase (user, cart_id, address)
    cart = CartService.get_cart(cart_id)
    unless cart
      return { errors: [{ message: 'Cart not found!' }], completed: false }
    end

    user = CartService.new(cart).get_user(user)

    if user.valid?
      order = OrderService.create_order(cart, user, address)
    
    if order.valid?
      return  { order: { id: order.id }, completed: true }
    else
      return { errors: order.errors.map(&:full_message).map { |message| { message: message } }, completed: false  }
    end
    else
      return { errors: user.errors.map(&:full_message).map { |message| { message: message } }, completed: false  }
    end

  end
end
