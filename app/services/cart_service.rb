class CartService
  def self.call(cart, user)
    new(cart, user).get_user
  end

  def initialize(cart, user)
    @cart = cart
    @user = user
  end

  def get_user
    if @cart.user.nil?
      user_params = @user ? @user : {}
      User.create(**user_params.merge(guest: true))
    else
      @cart.user
    end
  end
end
