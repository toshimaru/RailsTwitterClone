# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:slug)  { |n| "person-#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password 'FactoryGirl'
    password_confirmation 'FactoryGirl'

    factory :user1 do
      email 'user1@example.com'
    end
  end

  factory :tweet do
    sequence(:content) { |n| "Lorem ipsum #{n}" }
    user
  end
end
