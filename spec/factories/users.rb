# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider 'facebook'
    uid '1234567890'
    email 'test@test.com'
    password 'password'
    name 'Joe Bloggs'
    birthday '03/22/1989'
    location 'London, United Kingdom'
  end
end