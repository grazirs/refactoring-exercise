class CartService
  def initialize(cart)
    @cart = cart
  end
  def self.get_cart(cart_id)
    Cart.find_by(id: cart_id)
  end

  def get_user(user)
    if @cart.user.nil?
      user_params = user ? user : {}
      User.create(**user_params.merge(guest: true))
    else
      @cart.user
    end
  end

end
