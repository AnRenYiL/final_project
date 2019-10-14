class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :show]
  before_action :find_user, only: [:show, :edit, :update]

    def new
        @user = User.new
      end
      
    def create
      @user = User.new user_params
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Logged In!"
      else
        render :new
      end
    end

    def show
      
    end
    
    def edit
    
    end

    def update
      if @user.update user_params
        redirect_to root_path(@user)
      else
        render :edit
      end
    end
    
    def getUserByUserName
      if params[:user_name]
        user = User.find_by(user_name: params[:user_name])
        if user != nil
          render json: {user: user, status: 200 }
        else
          render json:{ errors: "null" , status: 404}
        end
      else
        render json:{ errors: "null", status: 404 }
      end
    end
    

    private
    
    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :picture_url,:description)
    end

    def find_user
      @user = current_user
    end
    
end
