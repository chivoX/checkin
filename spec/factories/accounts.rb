FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "TestUser #{n}" }
    last_name { 'Tester' }
    gender { 'Male' }
    user
  end
end
