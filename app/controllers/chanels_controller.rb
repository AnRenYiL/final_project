class ChanelsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_chanel, only: [:show, :destroy]
    def show
      updateLastCheckTime(@chanel.id)
      @message = Message.new
      channel_user = ChanelUser.where("user_id = #{current_user.id} AND chanel_id = #{@chanel.id}")[0]
      @messages = @chanel.messages.where("created_at <= '#{channel_user.last_check}' ").order(created_at:"desc").limit(20).reverse
      @unread_messages = @chanel.messages.where("created_at > '#{channel_user.last_check}' ").order(created_at:"desc").reverse
      @title = @chanel.title
      if @title == nil
        channel_user = @chanel.chanel_users.where("user_id != #{current_user.id}")
        @title = User.find(channel_user[0].user_id).user_name
      end
    end
    
    def new
      @chanel = Chanel.new
    end

    def create
      if params[:id_list]
        title = "group channel"
        if params[:channel_name] != ''
          title = params[:channel_name]
        end
        @chanel = Chanel.create(:is_group => true, :title => title)
        params[:id_list].each do |user_id|
          ChanelUser.create(:chanel_id => @chanel.id, :user_id => user_id, :last_check => Time.new)
        end
        ChanelUser.create(:chanel_id => @chanel.id, :user_id => current_user.id, :last_check => Time.new)
        render json:{ status: 200 }
      end

    end
    
    
    private
  
    def find_chanel
      @chanel ||= Chanel.find(params[:id])
    end


end
