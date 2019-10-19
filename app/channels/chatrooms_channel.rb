class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    current_user.channels.each do |channel|
      stream_from "chatrooms:#{channel.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
