require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: 'user@spec.io', first_name: 'John', last_name: 'Doe') }

  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_many(:carts) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
end
