class TurnsController < ApplicationController
  # before_action :turn_outcomes, only: [:show]

  def index
    @turns = Turn.all
  end

  def new
    @game = Game.find(params[:game_id])
    @turn = Turn.new(:game_id => @game.id, :user_energy => @current_energy) 
    @errors = flash[:errors]
  end

  def create
    @game = Game.find(params[:game_id])
    @turn = Turn.create(turn_params)
    # @turn.user_energy_pt
    if @turn.valid?
      @turn.outcomes
      if @turn.user_score >= 150 
        flash[:snitch] = "You caught the snitch!"
        redirect_to house_game_path(@current_user.house, @game)
        # byebug
      elsif @turn.computer_score >= 150
        flash[:snitch] = "Your opponent caught the snitch!"
        redirect_to house_game_path(@current_user.house, @game)
      else
        redirect_to house_game_turn_path(@current_user.house, @game, @turn)
      end
    else
      flash[:errors] = @turn.errors.full_messages
      redirect_to new_house_game_turn_path(@current_user.house, @game)
    end  
  end

  def show
    @turn = Turn.find(params[:id])
    @game = Game.find(params[:game_id])
  end


  private

  def turn_params
    params.require(:turn).permit(:game_id, :user_energy, :computer_energy, :user_score, :computer_score, :user_bludger_outcome, :computer_bludger_outcome, :user_snitch_chance, :computer_snitch_chance, :user_quaffle_allocation, :user_bludger_allocation, :user_snitch_allocation)
  end

  # def turn_outcomes
  #   @turn = Turn.find(params[:id])
  #   @end_of_turn = @turn.outcomes
  # end

end
