# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    first_name { 'Test' }
    last_name { 'Tester' }
    gender { 'Male' }
    user
  end
end
