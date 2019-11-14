FactoryBot.define do
  factory :account do
    sequence(:first_name) { |n| "TestUser #{n}" }
    last_name { 'Tester' }
    gender { 'Male' }
    user
  end
end
