require 'rails_helper'

RSpec.describe CartService do
  describe 'get user' do
    context 'there is a cart with valid user' do

      let!(:user) { create(:user) }
      let!(:cart) { create(:cart, user: user) }

      it 'should returns the user' do
        cart_user = CartService.call(cart, nil)
        expect(user).to eq(cart_user)
      end
    end

    context 'there is a cart without valid user' do
      it 'should returns the ' do
        new_cart = Cart.create!
        user_params = { email: 'user@spec.io', first_name: "John", last_name: "Doe" }
        expect{ CartService.call(new_cart, user_params) }.to change(User, :count).by(1)
      end
    end

  end
end
