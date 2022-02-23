require 'rails_helper'

RSpec.describe CartService do

  describe 'get cart' do
    context 'valid cart' do
      it 'should find a cart by id' do
        user = User.create!(email: 'user@spec.io', first_name: "John", last_name: "Doe", guest: false)
        new_cart = Cart.create!(user_id: user.id)
        cart = CartService.get_cart(1)
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
      it 'should returns the user' do
        user = User.create!(email: 'user@spec.io', first_name: "John", last_name: "Doe", guest: false)
        new_cart = Cart.create!(user_id: user.id)
        cart_user = CartService.new(new_cart).get_user(nil)
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
