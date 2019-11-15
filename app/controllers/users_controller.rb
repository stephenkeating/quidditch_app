class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  skip_before_action :authorized, only: [:new, :create]
    
  def new
    @user = User.new
    @answers_to_q_one = ["Ordinary", "Ignorant", "Cowardly", "Selfish"]
    @answers_to_q_two = ["Glory", "Wisdom", "Love", "Power"]
    @answers_to_q_three = ["Attempt to confuse the troll into letting all three of you pass without fighting", "Suggest drawing lots to decide which of you will fight", "Suggest that all three of you fight together", "Volunteer to fight by yourself"]
    @answers_to_q_four = ["The wide, sunny, grassy lane", "The narrow, dark, lantern-lit alley", "The twisting, leaf-strewn path through woods", "The cobbled street lined with ancient buildings"]
    @answers_to_q_five = ["Ask what makes them think so", "Agree, and ask whether they'd like a free sample of a jinx", "Agree, and walk away, leaving them to wonder whether you are bluffing", "Tell them that you are worried about their mental health, and offer to call a doctor"]
  end

  def create
    user = User.create(user_params)
    if user.valid? 
      user.sorting_hat
      session[:user_id] = user.id
      redirect_to sorted_path(user.house)
      # redirect_to house_path(user.house)
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
    params.require(:user).permit(:username, :password, :house_id, :answer_one, :answer_two, :answer_three, :answer_four, :answer_five)
  end

end
