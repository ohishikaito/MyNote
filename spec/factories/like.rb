FactoryBot.define do
  factory :like do
    association :tweet
    user { tweet.user }
  end
end
