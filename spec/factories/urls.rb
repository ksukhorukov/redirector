FactoryBot.define do
  factory :url do
    url { FFaker::Internet.uri('http') }
    short_url { "google_#{rand(100_000_000)}" }
  end
end
