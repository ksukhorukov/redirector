FactoryBot.define do
  factory :url do
    url { "http://google.com" }
    short_url { "google_#{rand(100_000_000)}" }
  end
end
