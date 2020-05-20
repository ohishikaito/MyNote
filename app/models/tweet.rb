class Tweet < ApplicationRecord

  def self.search(search)
    if search
      Tweet.where('title Like(?)', "%#{search}%")
    else
      Tweet.all
    end
  end

  #既にいいねしているか確認するメソッド
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # has_many :liked_tweets, through: :likes, source: :user

  validates :title, :text, presence: true, length: { maximum: 65_535 }
end
