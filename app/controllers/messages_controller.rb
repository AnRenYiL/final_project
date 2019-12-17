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

    def getMoreMsg
        if params[:first_id]
            chanel = Chanel.find(params[:chanel_id])
            messages = chanel.messages.where("id<#{params[:first_id].to_i}").order(created_at:"desc").limit(20).reverse
            html = ""
            messages.each do |message|
                user = message.user
                created_date = message.created_at.localtime
                if !user.picture_url.include? "http" 
                    html += 
                    # "<div  class='chatting-item' id='#{message.id}'><img src='../images/#{user.picture_url}'><div><strong>#{user.user_name}</strong><small>#{created_date.to_date == Time.new.localtime.to_date ? created_date.strftime("%I:%M %p") : created_date.strftime("%b %w %I:%M %p")}</small><p>#{message.body}</p></div></div>"
                    "<div  class='chatting-item' id='#{message.id}'><img src='../images/#{user.picture_url}'><div><strong>#{user.user_name}</strong><small>#{created_date.strftime("%I:%M %p")}</small><p>#{message.body}</p></div></div>"
                else
                    html += 
                    "<div  class='chatting-item' id='#{message.id}'><img src='#{user.picture_url}'><div><strong>#{user.user_name}</strong><small>#{created_date.strftime("%I:%M %p")}</small><p>#{message.body}</p></div></div>"
                end
            end
            if html != ""
                render json: {messages: html, status: 200 }
            else
                render json: {messages: nil, status: 204 }
            end
        end
    end
    
    

    private

    # def message_params
    #     params.require(:message).permit(:body)
    #   end

    def find_chanel
        @chanel = Chanel.find(params[:chanel_id])
    end
    
end
