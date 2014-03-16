# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'toshi'
    email 'toshi@factory.girl'
    password 'FactoryGirl'
    password_confirmation 'FactoryGirl'

    factory :user_having_different_email do
      email 'changed@mail.address'
    end
  end
end
