FactoryBot.define do
  factory :entry do
    # @user = create(:user)
    # @user2 = create(:user)
    # @room = create(:room)
    # @room2 = create(:room)
    user_id { FactoryBot.create(:user).id }
    room_id { FactoryBot.create(:room).id }
  end
end
