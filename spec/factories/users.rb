# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider 'facebook'
    uid '100007685170374'
    email 'gary_ggqwrri_oldman@tfbnw.net  '
    password '123testing'
    name 'Gary Oldman'
    birthday '08/08/1980'
    location 'London, United Kingdom'
    auth_token 'CAACqowAaUqEBAFs3qZBwzBlNWSqvDLhMpQZAGRIgTLPLb6X1HPYmyc0gAolgMn9o2tEf1drHmbYq9ai75WvMbOWyivv4I5fYycTQNWIs4Io0XlmV9tH94dXJgZCKs8FEDpSYZCvpxErUJBAtmZAlLiv87lkqZCFpsgYu59YIoEGDKFVqnNdg38Uzsj8jCPFc0ZD'
  end
end