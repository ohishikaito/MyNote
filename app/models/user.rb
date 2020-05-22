class User < ApplicationRecord

# devise_login------------------------------------------------------------------
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  validates :nickname, presence: true, uniqueness: true
  validates :email,  length: { maximum: 50 }
  mount_uploader :avatar, AvatarUploader
# tweets-------------------------------------------------------------------
  has_many :tweets
# comments-------------------------------------------------------------------
  has_many :comments
# likes-------------------------------------------------------------------
  has_many :likes
  has_many :liked_tweets, through: :likes, source: :tweet
# messages-------------------------------------------------------------------
  has_many :messages
  has_many :entries
  has_many :rooms, through: :entries
# follow------------------------------------------------------------------
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship"
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship"
  has_many :followers, through: :follower_relationships

  #フォローしているかを確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  #フォローするときのメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  #フォローを外すときのメソッド
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

end
