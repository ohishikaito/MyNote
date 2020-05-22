module RoomsHelper

    def most_new_message_preview(room)
        lastMessage = room.messages.order(created_at: :desc).limit(1)
        @message = lastMessage[0]
        @message.present?
        tag.p "#{@message.message}", class: "empty"
    end

    def most_new_message_date(room)
        lastMessage = room.messages.order(created_at: :desc).limit(1)
        @message = lastMessage[0]
        @message.present?
        tag.p "#{@message.updated_at.strftime("%Y-%m-%d %H:%M")}"
    end

    def opened_user(room)
        entry = room.entries.where.not(user_id: current_user)
        nickname = entry[0].user.nickname
        tag.p "#{nickname}"
    end
end
