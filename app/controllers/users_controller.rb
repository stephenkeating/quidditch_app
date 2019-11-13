class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
    def new
        @user = User.new
    end

    def create
        user_params = params.require(:user).permit(:username, :password, :house_id)
        user = User.create(user_params)
      
        if user.valid?
          session[:user_id] = user.id
          redirect_to houses_path
        else
          flash[:errors] = user.errors.full_messages
          redirect_to signup_path
        end
      
      end     
     
end
