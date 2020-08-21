FactoryBot.define do
  factory :donation do
    association :tweet
    user { tweet.user }
    amount { 10_000 }
  end
end
