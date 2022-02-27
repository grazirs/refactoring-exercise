require 'rails_helper'

RSpec.describe PurchaseService do

  describe 'purchase' do
    let!(:user) { create(:user) }
    let(:address) do { 
      address_1: 'Av bla',
      address_2: 'Av Loop',
      city: 'Porto',
      state: 'SP',
      country: 'Brazil',
      zip: '2344567'
    }
    end
    context 'when choose a invalid gateway' do      
      let!(:cart) { create(:cart, user: user) }

      it 'returns a message error' do
        params = {
          user: user, 
          cart_id: cart.id,
          address: address,
          gateway: nil
        }
        result = PurchaseService.purchase(params)
        expect(result[:errors][0][:message]).to eq('Gateway not supported!') 
      end
    end

    context 'when the cart does not exist' do
      it 'returns a message error' do
        params = {
          user: user, 
          cart_id: nil,
          address: address,
          gateway: 'paypal'
        }
        result = PurchaseService.purchase(params)
        expect(result).to eq( { errors: [{ message: 'Cart not found!' }], completed: false } )
      end
    end

    context 'when all the data are valid' do
      let!(:cart) { create(:cart, user: user) }

      it 'completes the order' do
        params = {
          user: user, 
          cart_id: cart.id,
          address: address,
          gateway: 'paypal'
        }
        result = PurchaseService.purchase(params)
        expect(result).to eq ( { order: { id: Order.last.id }, completed: true } )
      end
    end

    context 'when order is invalid' do
      let!(:cart) { create(:cart, user: nil) }

      it 'does not complete the order' do
        params = {
          user: nil, 
          cart_id: cart.id,
          address: address,
          gateway: 'paypal'
        }
        result = PurchaseService.purchase(params)
        expect(result[:completed]).to eq (false)
      end
    end
  end
end
