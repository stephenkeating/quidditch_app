class ApplicationController < ActionController::Base

    def turn_outcomes
        @turn = Turn.find(params[:id])
        @end_of_turn = @turn.outcomes
    end

end
