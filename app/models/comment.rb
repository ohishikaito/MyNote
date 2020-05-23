class Comment < ApplicationRecord
# tweets-------------------------------------------------------------------
  belongs_to :tweet
# users-------------------------------------------------------------------
  belongs_to :user
# comments-------------------------------------------------------------------
  validates :content, presence: true
# notifications-------------------------------------------------------------------
  has_many :notifications, dependent: :destroy

end
