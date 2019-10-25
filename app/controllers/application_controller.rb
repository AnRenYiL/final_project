class ApplicationController < ActionController::Base
    def current_user
      @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method :current_user

    def user_signed_in?
      current_user.present?
    end
    helper_method :user_signed_in?

    def authenticate_user!
      unless user_signed_in?
        flash[:danger] = "Please Sign In"
        redirect_to new_session_path
      end
    end

    def getFriendList
      @friends = []
      if current_user.present?
        @friends = User.select("users.*, chanels.id as chanel_id").joins("INNER JOIN chanel_users ON chanel_users.user_id = users.id INNER JOIN chanels ON chanels.id = chanel_users.chanel_id").where("chanel_users.chanel_id in (SELECT chanels.id FROM chanels INNER JOIN chanel_users ON chanel_users.chanel_id = chanels.id WHERE chanel_users.user_id = #{current_user.id} AND chanels.is_group = false) AND chanel_users.user_id != #{current_user.id}").order("chanels.created_at": :asc)
      end
      @friends
    end
    helper_method :getFriendList

    def getGroupChannels
      @group_chanels = []
      if current_user.present?
        @group_chanels = current_user.group_chanels
      end
      @group_chanels
    end
    helper_method :getGroupChannels

    def updateLastCheckTime(channel_id)
      # byebug
      if session[:channel_id] 
        channel_user = ChanelUser.where("user_id = #{current_user.id} AND chanel_id = #{session[:channel_id]}")[0]
        channel_user.update(last_check: Time.new)
      end
      if channel_id
        session[:channel_id] = channel_id
      end
    end
    helper_method :updateLastCheckTime

    def un_read_msg(channel_id)
      channel_user = ChanelUser.where("user_id = #{current_user.id} AND chanel_id = #{channel_id}")[0]
      channel = Chanel.find(channel_id)
      msg_number = channel.messages.where("created_at > '#{channel_user.last_check}' AND user_id != #{current_user.id} ").count()
      if msg_number > 0
        return true
      else
        return false
      end
    end
    helper_method :un_read_msg
end
