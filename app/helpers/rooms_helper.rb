module RoomsHelper

    def opened_user(room)
        entry = room.entries.where.not(user_id: current_user)
        user = entry[0].user
    end

    def get_most_new_message(room)
        lastMessage = room.messages.order(created_at: :desc).limit(1)
        message = lastMessage[0]
    end

end
