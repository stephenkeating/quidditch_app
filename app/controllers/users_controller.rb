class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  skip_before_action :authorized, only: [:new, :create]
    
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
  
    if user.valid?
      session[:user_id] = user.id
      redirect_to house_path(user.house)
    else
      flash[:errors] = user.errors.full_messages
      redirect_to signup_path
    end
  end  
  
  def edit

  end

  def update
    @user.update(user_params)

    redirect_to user_path(@current_user.id)
  end

  def destroy
    @user.destroy
    redirect_to signup_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :house_id)
  end

end
