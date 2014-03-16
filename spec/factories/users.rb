# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'toshi'
    email 'toshi@factory.girl'
    password 'FactoryGirl'
    password_confirmation 'FactoryGirl'
  end
end
