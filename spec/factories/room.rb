FactoryBot.define do
  factory :room do
    association :user
    association :room
    association :message
  end
end