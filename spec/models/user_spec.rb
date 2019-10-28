require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:events) }
    it { is_expected.to have_one(:account) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to allow_value('test@test.com').for(:email) }
    it { is_expected.to_not allow_value('foo').for(:email) }
    it { create(:user); is_expected.to validate_uniqueness_of(:email) }
  end
end
