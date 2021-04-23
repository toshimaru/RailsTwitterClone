# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    recipient { nil }
    type { "" }
    params { "" }
    read_at { "2021-04-11 13:12:57" }
  end
end
