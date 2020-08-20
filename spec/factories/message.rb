FactoryBot.define do
  factory :message do
    user
    room
    message   { Faker::Lorem.word }
  end
end