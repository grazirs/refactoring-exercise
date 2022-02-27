require 'rails_helper'

RSpec.describe OrderService do

  describe 'create order' do
    let!(:user) { create(:user) }
    let!(:cart) { create(:cart, user: user) }
    
    it 'creates a new order' do
      address = { 
        address_1: 'Av bla',
        address_2: 'Av Loop',
        city: 'Porto',
        state: 'SP',
        country: 'Brazil',
        zip: '2344567'
      }
      expect { OrderService.create_order(cart, user, address) }.to change(Order, :count).by(1) 
    end
  end
end
