class ChanelsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_chanel, only: [:show, :destroy]
    def show
      @message = Message.new
      @messages = @chanel.messages.order(created_at:"desc").limit(20).reverse
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
          ChanelUser.create(:chanel_id => @chanel.id, :user_id => user_id)
        end
        ChanelUser.create(:chanel_id => @chanel.id, :user_id => current_user.id)
        render json:{ status: 200 }
      end

    end
    
    
    private
  
    def find_chanel
      @chanel ||= Chanel.find(params[:id])
    end
end
