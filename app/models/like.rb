class Like < ApplicationRecord
  # likes-------------------------------------------------------------------
  validates :tweet_id, uniqueness: { scope: :user_id }, presence: :true
  validates :user_id, presence: true
  # tweets-------------------------------------------------------------------
  belongs_to :tweet, counter_cache: :likes_count
  # users-------------------------------------------------------------------
  belongs_to :user
end
