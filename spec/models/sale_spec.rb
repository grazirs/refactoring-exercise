require 'rails_helper'

RSpec.describe Sale, type: :model do
  it { is_expected.to validate_presence_of(:unit_price_cents) }
  it { is_expected.to validate_numericality_of(:unit_price_cents).only_integer }
end
