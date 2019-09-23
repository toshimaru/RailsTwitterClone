# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    sequence(:content) { Faker::Quote.famous_last_words }
    user
  end
end
