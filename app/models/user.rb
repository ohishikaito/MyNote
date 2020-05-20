class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  
  has_many :tweets
  has_many :comments
  has_many :likes
  # has_many :liked_tweets, through: :likes, source: :tweet
  
  validates :nickname, presence: true, uniqueness: true

end
