FactoryBot.define do
  factory :comment do
    association :tweet
    user { tweet.user }
    content { Faker::Lorem.word }
  end
end
