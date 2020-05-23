class Like < ApplicationRecord
# likes-------------------------------------------------------------------
  validates :tweet_id, uniqueness: { scope: :user_id }
# tweets-------------------------------------------------------------------
  belongs_to :tweet
# users-------------------------------------------------------------------
  belongs_to :user
# notifications-------------------------------------------------------------------
  # has_many :notifications, dependent: :destroy
  
end
