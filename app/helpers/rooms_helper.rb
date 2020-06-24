module RoomsHelper
  def opened_user(room)
    entry = room.entries.where.not(user_id: current_user)
    entry[0].user
  end

  def get_most_new_message(room)
    last_message = room.messages.order(created_at: :desc).limit(1)
    last_message[0]
  end
end
