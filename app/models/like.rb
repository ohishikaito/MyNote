class Like < ApplicationRecord
# likes-------------------------------------------------------------------
  validates :tweet_id, uniqueness: { scope: :user_id }
# tweets-------------------------------------------------------------------
  belongs_to :tweet, counter_cache: :likes_count
# users-------------------------------------------------------------------
  belongs_to :user
  
end
