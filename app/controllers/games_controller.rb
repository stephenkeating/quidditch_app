class GamesController < ApplicationController

    def index
        @games = Game.all
    end

    def show #update tie message
        @house = House.find(params[:house_id])
        # byebug
        @game = Game.find(params[:id])
        @user_score = @game.turns.calculate(:sum, :user_score)
        @computer_score = @game.turns.calculate(:sum, :computer_score)
        if @user_score > @computer_score
            @winner = House.find_by(id: @game.user_house_id).name
        elsif @computer_score > @user_score
            @winner = House.find_by(id: @game.computer_house_id).name
        else
            @winner = "Believe it or not, it was a tie. Quidditch is strange."
        end
    end
    
    def new
        @game = Game.new
    end

    def create
        @game = Game.create(game_params)
        # byebug
        redirect_to new_house_game_turn_path(@current_user.house, @game)
    end

    private

    def game_params
        params.require(:game).permit(:user_house_id, :computer_house_id)
    end

end
