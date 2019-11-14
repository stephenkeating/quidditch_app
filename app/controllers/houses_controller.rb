class HousesController < ApplicationController
    before_action :set_house, only: [:show, :ghost]

    def index
        @houses = House.all
    end

    def show
        
    end

    def ghost
        @ghost_words = @house.talk_to_house_ghost
    end

    private

    def set_house
        @house = House.find(params[:id])
    end
end
