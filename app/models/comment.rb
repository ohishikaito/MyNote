class Comment < ApplicationRecord
  # tweets-------------------------------------------------------------------
  belongs_to :tweet
  # users-------------------------------------------------------------------
  belongs_to :user
  # comments-------------------------------------------------------------------
  validates :content, presence: true, length: { maximum: 1000 }
  # notifications-------------------------------------------------------------------
  has_many :notifications, dependent: :destroy
end
