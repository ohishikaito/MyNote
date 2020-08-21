FactoryBot.define do
  factory :message do
    # user
    # room
    # association :user
    # association :room
    # user_id   { user.id }
    # room_id   { room.id }
    user_id{FactoryBot.create(:user).id}
    room_id{FactoryBot.create(:room).id}
    message   { Faker::Lorem.word }
  end
end