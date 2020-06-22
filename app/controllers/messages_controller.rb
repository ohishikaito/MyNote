class MessagesController < ApplicationController
  before_action :set_room, only: %i[create edit update destroy]
  before_action :set_message, only: %i[edit update destroy]

  def create
    @message = Message.create(message_params)
    if @message.save
      @room.create_notification_message!(current_user, @message.id)
      gets_entries_all_messages
      @message = Message.new
    end
  end

  def edit; end

  def update
    gets_entries_all_messages if @message.update(message_params)
  end

  def destroy
    gets_entries_all_messages if @message.destroy
  end

  private

  def set_room
    @room = Room.find(params[:message][:room_id])
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def gets_entries_all_messages
    @messages = @room.messages.includes(:user).order("created_at asc")
    @entries = @room.entries
  end

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end
end
