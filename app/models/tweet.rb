class Tweet < ApplicationRecord

  def self.search(search)
    if search
      Tweet.where('title Like(?)', "%#{search}%")
    else
      Tweet.all
    end
  end

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :text, presence: true
end
