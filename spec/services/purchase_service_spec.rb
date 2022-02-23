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

      it 'should returns a message error' do
      result = PurchaseService.purchase(user, cart.id, address, nil)
      expect(result).to eq( { errors: [{ message: 'Gateway not supported!' }], completed: false } ) 
      end
    end

    context 'when the cart does not exist' do
      it 'should returns a message error' do
        result = PurchaseService.purchase(user, nil, address, 'paypal' )
        expect(result).to eq( { errors: [{ message: 'Cart not found!' }], completed: false } )
      end
    end

    context 'when all the data are valid' do
      let!(:cart) { create(:cart, user: user) }

      it 'should complete the order' do
        result = PurchaseService.purchase(user, cart.id, address, 'paypal' )
        expect(result).to eq ( { order: { id: Order.last.id }, completed: true } )
      end
    end

    context 'when order is invalid' do
      let!(:cart) { create(:cart, user: nil) }

      it 'should not complete the order' do
        result = PurchaseService.purchase( nil, cart.id, address, 'paypal' )
        expect(result[:completed]).to eq (false)
      end
    end

  end
end
