# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'alex@alex.com'
    password 'password'
    password_confirmation { password }
    provider 'facebook'
    uid '1234567890'
  end
end