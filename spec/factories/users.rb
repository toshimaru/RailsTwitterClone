# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:slug)  { |n| "person-#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password { "FactoryBot" }
    password_confirmation { "FactoryBot" }

    factory :user1 do
      email { "user1@example.com" }
    end
  end
end
