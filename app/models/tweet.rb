class Tweet < ApplicationRecord
  # search-------------------------------------------------------------------
  def self.search(search)
    if search
      Tweet.where('title Like(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
  # likes-------------------------------------------------------------------
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 既にいいねしているか確認するメソッド
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  # ランキングメソッド
  def self.create_all_ranks
    Tweet.includes(%i[taggings user]).find(Like.group(:tweet_id).order('count(tweet_id) desc').limit(10).pluck(:tweet_id))
  end
  # tweets-------------------------------------------------------------------
  mount_uploader :image, ImageUploader
  validates :text, presence: true, length: { maximum: 65_535 }
  validates :title, presence: true, length: { maximum: 40 }
  # users-------------------------------------------------------------------
  belongs_to :user
  # comments-------------------------------------------------------------------
  has_many :comments, dependent: :destroy
  # notifications -------------------------------------------------------------------
  has_many :notifications, dependent: :destroy

  def create_notification_like!(current_user)
    # 既にいいねされてるか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and tweet_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされてなかったら通知を作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        tweet_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿にはいいね通知済みにする
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(tweet_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      tweet_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
  # ActAsTaggable-------------------------------------------------------------------
  acts_as_taggable
  # donations-------------------------------------------------------------------
  has_many :donations, dependent: :destroy
end
