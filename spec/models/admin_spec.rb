# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_digest) }
    it { is_expected.to allow_value('test@test.com').for(:email) }
    it { is_expected.to_not allow_value('foo').for(:email) }
    it { create(:user); is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'Instance methods' do
    context '#full_name' do
      let(:admin) { create(:admin, email: 'test@test.com') }
      it 'returns the admins email' do
        expect(admin.full_name).to eq('test@test.com')
      end
    end
  end
end
