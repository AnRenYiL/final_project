class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message.chanel_id}",{
      message: MessagesController.render(message),
      chatroom_id: message.chanel_id
    }
  end
end
