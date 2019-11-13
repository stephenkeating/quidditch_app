class TurnsController < ApplicationController
  # before_action :turn_outcomes, only: [:show]

  def index
    @turns = Turn.all
  end

  def new
    @game = Game.find(params[:game_id])
    @turn = Turn.new(:game_id => @game.id) 
    
  end

  def create
    @game = Game.find(params[:game_id])
    @turn = Turn.create(turn_params)
    @turn.user_energy_pt
    @turn.outcomes
    if @turn.user_score >= 150 || @turn.computer_score >= 150
      @game.game_over
      redirect_to @game
    else
      redirect_to game_turn_path(@game, @turn)
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
