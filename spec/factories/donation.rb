FactoryBot.define do
  factory :donation do
    association :tweet
    user { tweet.user }
    amount  { 10000 }
  end
end