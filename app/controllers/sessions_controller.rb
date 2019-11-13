class SessionsController < ApplicationController
    skip_before_action :authorized, only: [:new, :create]
 
 def new
 end
 
 def create
   user = User.find_by(username: params[:session][:username])
   if user && user.authenticate(params[:session][:password])
     session[:user_id] = user.id
     redirect_to houses_path
   else
      byebug
     flash[:errors] = user.errors.full_messages
     redirect_to login_path
   end
 end
 
 def destroy
   session.delete(:user_id)
   redirect_to login_path
 end

end