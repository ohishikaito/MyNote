class Like < ApplicationRecord

  belongs_to :tweet
  belongs_to :user

  validates :tweet_id, uniqueness: { scope: :user_id }
  #validates :tweet_id, scope: :user_id, uniqueness: trueでもいいのでは？
  # validates :user_id, :tweet_id, presence: true
  
end
