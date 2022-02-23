require 'rails_helper'

RSpec.describe CartService do

  describe 'get cart' do

    context 'valid cart' do

      let!(:user) { create(:user) }
      let!(:cart) { create(:cart, user: user) }

      it 'should find a cart by id' do
        new_cart = CartService.get_cart(1)
        expect(cart).to eq(new_cart)
      end
    end

    context 'invalid cart' do
      it 'should not find a cart by id' do
        cart = CartService.get_cart(1)
        expect(cart).to eq(nil)
      end
    end
  end

  describe 'get user' do
    context 'there is a cart with valid user' do

      let!(:user) { create(:user) }
      let!(:cart) { create(:cart, user: user) }

      it 'should returns the user' do
        cart_user = CartService.new(cart).get_user(nil)
        expect(user).to eq(cart_user)
      end
    end

    context 'there is a cart without valid user' do
      it 'should returns the ' do
        new_cart = Cart.create!
        user_params = { email: 'user@spec.io', first_name: "John", last_name: "Doe" }
        expect{ CartService.new(new_cart).get_user(user_params)}.to change(User, :count).by(1)
      end
    end

  end
end
