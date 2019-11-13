class GamesController < ApplicationController

    def index
        @games = Game.all
    end
    
    def new
        @game = Game.new
    end

    def create
        @game = Game.create(game_params)
        # byebug
        redirect_to new_game_turn_path(@game)
    end

    private

    def game_params
        params.require(:game).permit(:user_house_id, :computer_house_id)
    end
end
