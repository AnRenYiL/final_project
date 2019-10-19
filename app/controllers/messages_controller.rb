class MessagesController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :find_chanel

    def create
    #    byebug
        message = Message.new(body: params[:message][:body])
        message.user = current_user
        message.chanel = @chanel 
        message.save
        # redirect_to @chanel
        # byebug
        # render json: {message: message, status: 200 }
        MessageRelayJob.perform_later(message)
        # ActionCable.server.broadcast "chatrooms:#{message.chanel_id}",{
        #     message: MessagesController.render(message),
        #     chatroom_id: message.chanel_id
        # }
    end
    

    private

    # def message_params
    #     params.require(:message).permit(:body)
    #   end

    def find_chanel
        @chanel = Chanel.find(params[:chanel_id])
    end
    
end
