class PurchaseService
  def self.purchase (user, cart_id, address, gateway)
    if ['paypal', 'stripe'].include? gateway
      cart = Cart.find_by(id: cart_id)
      unless cart
        return { errors: [{ message: 'Cart not found!' }], completed: false }
      end

      user = CartService.call(cart, user)

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
    else
      return { errors: [{ message: 'Gateway not supported!' }], completed: false }
    end
  end
end
