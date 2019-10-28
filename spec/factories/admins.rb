FactoryBot.define do
  factory :admin, class: Admin do
    sequence(:email) { |n| "test#{n}@admin.com" }
    password { '123456789' }
    password_confirmation { '123456789' }
  end
end
