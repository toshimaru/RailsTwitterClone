# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    sequence(:content) { |n| "Lorem ipsum #{n}" }
    user
  end
end
