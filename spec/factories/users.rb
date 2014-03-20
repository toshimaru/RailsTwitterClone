# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password 'FactoryGirl'
    password_confirmation 'FactoryGirl'

    factory :user_having_different_email do
      email 'changed@mail.address'
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
