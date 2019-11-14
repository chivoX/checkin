# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:checkin) }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  describe 'Instance methods' do
    context '#total_worked_hours' do
      context 'when checkin and checkout are present' do
        let(:event) { create(:event) }

        it 'returns the calculated worked hours' do
          expect(event.total_worked_hours).to eq(3)
        end
      end

      context 'when checkin or checkout arent present' do
        let(:event) { build(:event, checkin: nil, checkout: nil) }

        it 'returns nil' do
          expect(event.total_worked_hours).to be_nil
        end
      end
    end
  end
end
