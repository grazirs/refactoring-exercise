require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it { is_expected.to belong_to(:cart) }
  it { is_expected.to belong_to(:sale) }

  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_numericality_of(:quantity).only_integer }

  describe '#price_total_cents' do
    subject { item.price_total_cents }

    let(:sale) { build_stubbed(:sale, unit_price_cents: 500) }
    let(:item) { build_stubbed(:cart_item, sale: sale, quantity: 2) }

    it { is_expected.to eq 1_000 }
  end
end
