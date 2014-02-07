# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider 'facebook'
    uid '100007685170374'
    email 'gary_ggqwrri_oldman@tfbnw.net'
    password '123testing'
    name 'Gary Oldman'
    birthday '08/08/1980'
    location 'London, United Kingdom'
    auth_token 'CAACqowAaUqEBAC3w95TvgRzGQzkG0fs46tWTNKxEe7UowMvJC7SH5z1S4UkBCMAiH8P6ZCUnOFotWgV0PZAIwNjaiOHUuwDKhZCFzZAFDPmccqV9ZArTWUucZCK3Q7C5BZACLOStnBZCyneM0VLA5VpTe4W3nZBXo3slXy5HZBGTPIqv0MOPRuHJeAAI7jhLjiyK8ZD'
  end
end