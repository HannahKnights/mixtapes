FactoryGirl.define do
  factory :user_account do
    user

    provider 'facebook'
    uid 'facebook-user-id'

    trait :facebook do
      provider 'facebook'
      email 'fake@fake.com'
    end

  end
end