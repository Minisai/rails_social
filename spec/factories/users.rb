# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    confirmed_at Time.now
  end
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

