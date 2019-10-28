FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "test#{n}@user.com" }
    password { '123456789' }
    password_confirmation { '123456789' }

    factory :user_with_account do
      after(:create) do |user|
        create(:account, user: user)
        create_list(:event, 3, user: user)
      end
    end
  end
end
