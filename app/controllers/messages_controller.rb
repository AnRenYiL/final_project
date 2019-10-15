class MessagesController < ApplicationController
    before_action :find_chanel

    def create
        message = Message.new message_params
        message.user = current_user
        message.chanel = @chanel 
        if message.save
            redirect_to chanel_path(@chanel)
          else
            render :new
          end
    end
    

    private

    def message_params
        params.require(:message).permit(:body)
      end

    def find_chanel
        @chanel = Chanel.find(params[:chanel_id])
    end
    
end
