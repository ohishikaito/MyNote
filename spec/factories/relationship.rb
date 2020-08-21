FactoryBot.define do
  factory :relationship do
    follower_id    { FactoryBot.create(:user).id }
    following_id   { FactoryBot.create(:user).id }
  end
end
