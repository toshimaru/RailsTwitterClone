# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name)  { Faker::Name.name }
    sequence(:slug)  { |n| "#{Faker::Internet.slug}-#{n}" }
    sequence(:email) { |n| "#{n}-#{Faker::Internet.free_email}" }
    password { "FactoryBot" }
    password_confirmation { "FactoryBot" }
  end
end
