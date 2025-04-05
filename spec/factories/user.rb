# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    sequence(:slug)  { |n| "#{Faker::Internet.slug}-#{n}" }
    sequence(:email) { |n| "#{n}-#{Faker::Internet.email}" }
    password { "FactoryBot" }
    password_confirmation { "FactoryBot" }

    trait :admin do
      admin { true }
    end
  end
end
