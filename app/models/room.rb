class Room < ApplicationRecord
  # messages-------------------------------------------------------------------
  has_many :messages
  has_many :entries
  has_many :users, through: :entries
  # notifications-------------------------------------------------------------------
  has_many :notifications
  def create_notification_message!(current_user, message_id)
    temp_ids = Entry.select(:user_id).where(room_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      notification = current_user.active_notifications.new(
        room_id: id,
        message_id: message_id,
        visited_id: temp_id['user_id'],
        action: 'message'
      )
      notification.save
    end
  end
end
