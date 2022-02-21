require 'rails_helper'

RSpec.describe OrderLineItem, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:sale) }

  it { is_expected.to validate_presence_of(:unit_price_cents) }
  it { is_expected.to validate_numericality_of(:unit_price_cents).only_integer }
  it { is_expected.to validate_presence_of(:paid_price_cents) }
  it { is_expected.to validate_numericality_of(:paid_price_cents).only_integer }
end
