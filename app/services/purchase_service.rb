class PurchaseService

  ALLOWED_GATEWAYS = ['paypal', 'stripe']

  def self.purchase (purchase_params)
    if ALLOWED_GATEWAYS.include? purchase_params[:gateway]
      cart = Cart.find_by(id: purchase_params[:cart_id])
      unless cart
        return { errors: [{ message: 'Cart not found!' }], completed: false }
      end

      user = CartService.call(cart, purchase_params[:user])

        if user.valid?
          order = OrderService.create_order(cart, user, purchase_params[:address])
          if order.valid?
            return  { order: { id: order.id }, completed: true }
          else
            build_error_response(order.errors)
          end
        else
          build_error_response(user.errors)
        end
    else
      return { errors: [{ message: 'Gateway not supported!' }], completed: false }
    end
  end

  private

  def self.build_error_response(errors)
    return { errors: errors.map(&:full_message).map { |message| { message: message } }, completed: false  }
  end
end
