class TurnsController < ApplicationController

  def new
    @turn = Turn.new 
    @q_energy
  end
end
