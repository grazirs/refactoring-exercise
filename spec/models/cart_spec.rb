require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { is_expected.to belong_to(:user).optional(true) }
  it { is_expected.to have_many(:items).class_name('CartItem').dependent(:destroy) }

  describe '#amount_to_pay_cents' do
    subject { cart.amount_to_pay_cents }

    context 'when cart is not empty' do
      let(:sale1) { build_stubbed(:sale, unit_price_cents: 500) }
      let(:sale2) { build_stubbed(:sale, unit_price_cents: 200) }
      let(:item1) { build_stubbed(:cart_item, sale: sale1, quantity: 3) }
      let(:item2) { build_stubbed(:cart_item, sale: sale2, quantity: 2) }

      let(:cart) { build_stubbed(:cart) }

      before do
        allow(cart).to receive(:items).and_return([item1, item2])
      end

      it { is_expected.to eq 1_900 }
    end

    context 'when cart is empty' do
      let(:cart) { build_stubbed(:cart) }

      before do
        allow(cart).to receive(:items).and_return([])
      end

      it { is_expected.to be_zero }
    end
  end
end
