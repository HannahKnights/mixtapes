# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :like do
    like false
    user_mix_id 1
    match_mix_id 1
    block false
  end
end
