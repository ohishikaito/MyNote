# t.integer "visitor_id", null: false
# t.integer "visited_id", null: false
# t.integer "tweet_id"
# t.integer "comment_id"
# t.integer "message_id"
# t.integer "room_id"
# t.string "action", default: "", null: false
# t.boolean "checked", default: false, null: false

FactoryBot.define do
  factory :notification do
    # ページ遷移するとcheckedが変わるテストしてみたい
  end
end
