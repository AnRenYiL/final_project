class ChanelsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_chanel, only: [:show, :destroy]
    def show
      @message = Message.new
      @messages = @chanel.messages.order(created_at:"desc").limit(20).reverse
    end
    
    private
  
    def find_chanel
      @chanel ||= Chanel.find(params[:id])
    end
end
