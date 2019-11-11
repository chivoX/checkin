# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    checkin { Time.now }
    checkout { Time.now + 3.hours }
    user { create(:user) }
  end
end
