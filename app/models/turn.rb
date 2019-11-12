class Turn < ApplicationRecord
  belongs_to :game

  #will Turn.last work?
  def comp_energy_pt
    if self.game.turns.count == 1
      @computer_energy_points = 10
    else
      @computer_energy_points = 10 + Turn.last.computer_bludger_outcome  
    end
  end
  
  def computer_energy_array
    a = []
    a << first_integer = rand(0..comp_energy_pt)
    a << second_integer = rand(0..(comp_energy_pt - first_integer))
    a << comp_energy_pt - (first_integer + second_integer)
    a.shuffle
  end

  def allocate_comp_energy
    a = computer_energy_array
    @q_energy = a[0]
    @b_energy = a[1]
    @s_energy = a[2]
  end

  #how do instance variables work lol
  def assign_bonuses
    allocate_comp_energy
    if self.user_quaffle_allocation > @s_energy
      @uq_bonus = (2 * (self.user_quaffle_allocation - @s_energy) - 1)
    end 

    if @q_energy > self.user_snitch_allocation 
     @cq_bonus = (2 * (@q_energy - self.user_snitch_allocation) - 1)
    end

    if self.user_bludger_allocation > @q_energy
      @ub_bonus = (2 * (self.user_bludger_allocation - @q_energy) - 1)
    end

    if @b_energy > self.user_quaffle_allocation 
      @cb_bonus = (2 * (@b_energy - self.user_quaffle_allocation) - 1)
    end

    if self.user_snitch_allocation > @b_energy
      @us_bonus = (2 * (self.user_snitch_allocation - @b_energy) - 1)
    end

    if @s_energy > self.user_bludger_allocation
      @cs_bonus = (2 * (self.user_bludger_allocation) - 1)
    end
  end

  def generate_comparison_values  #think later if 5 is a good starting max range for Q/B/S
    assign_bonuses
    if @cq_bonus 
      @computer_quaffle_value = rand(1..(5 + @q_energy + @cq_bonus))
    else
      @computer_quaffle_value = rand(1..(5 + @q_energy))
    end

    if @cb_bonus 
      @computer_bludger_value = rand(1..(5 + @b_energy + @cb_bonus))
    else
      @computer_bludger_value = rand(1..(5 + @b_energy))
    end

    if @cs_bonus 
      @computer_snitch_value = rand(1..(3 + @s_energy + @cs_bonus))
    else
      @computer_snitch_value = rand(1..(3 + @s_energy))
    end

    if @uq_bonus 
      @user_quaffle_value = rand(1..(5 + self.user_quaffle_allocation + @uq_bonus))
    else
      @user_quaffle_value = rand(1..(5 + self.user_quaffle_allocation))
    end

    if @ub_bonus 
      @user_bludger_value = rand(1..(5 + self.user_bludger_allocation + @ub_bonus))
    else
      @user_bludger_value = rand(1..(5 + self.user_bludger_allocation))
    end

    if @us_bonus 
      @user_snitch_value = rand(1..(3 + self.user_snitch_allocation + @us_bonus))
    else
      @user_snitch_value = rand(1..(3 + self.user_snitch_allocation))
    end

  end

  def outcomes # tomorrow: make sure snitch odds are working. make sure they update from turn to turn. 
    generate_comparison_values
    if @user_quaffle_value > @computer_quaffle_value
      self.user_score = 10
      self.computer_score = 0
      p "user scored"
    elsif @computer_quaffle_value > @user_quaffle_value
      self.user_score = 0
      self.computer_score = 10
      p "computer scored"
    else 
      self.user_score = 0
      self.computer_score = 0
      p "no one scored"
    end

    if @user_bludger_value > @computer_bludger_value
      self.user_bludger_outcome = 5
      self.computer_bludger_outcome = -2
      p "user bludgered"
    elsif @computer_bludger_value > @user_bludger_value
      self.user_bludger_outcome = -2
      self.computer_bludger_outcome = 5
      p "computer bludgered"
    else 
      self.user_bludger_outcome = 0
      self.computer_bludger_outcome = 0
      p "no one bludgered"
    end

    if @user_snitch_value > @computer_snitch_value
      p "user went for the snitch"
      self.user_snitch_chance = (@user_snitch_value - @computer_snitch_value)
      self.computer_snitch_chance = 0
      # call self.game.turns and then sum the user snitch chance column
      # stephen is desperate to simplify this with activerecord
      y = self.game.turns.map do |turn|
        turn.user_snitch_chance
      end
      x = y.inject(0, :+)

      snitch_odds = rand(1..x)

      r = rand(5..100)

      if snitch_odds > r
        self.user_score += 150
        p "user caught snitch"
        #trigger game over logic
      end


    elsif @computer_snitch_value > @user_snitch_value
      p "computer went for the snitch"
      self.computer_snitch_chance = (@computer_snitch_value - @user_snitch_value)
      self.user_snitch_chance = 0
      # call self.game.turns and then sum the user snitch chance column
      # stephen is desperate to simplify this with activerecord
      y = self.game.turns.map do |turn|
        turn.computer_snitch_chance
      end
      x = y.inject(0, :+)

      snitch_odds = rand(1..x)

      r = rand(5..100)
      
      if snitch_odds > r
        self.computer_score += 150
        p "computer caught snitch"
        #trigger game over logic
      end
    else 
      self.user_snitch_chance = 0
      self.computer_snitch_chance = 0
      p "no one went for the snitch"
    end
  end

end




# Code we found to generate random numbers:
# class Fixnum
#   def rand_sum(n = 2)
#     arr = (n - 1).times.reduce([]) do |a, _|
#       curr_max = self - a.reduce(0, :+)
#       a << rand(0..curr_max)
#     end

#     arr << self - arr.reduce(0, :+)
#   end
# end

# then add .scramble to the end
# then array[0] = quaffle, array[1] = bludger, array[2] = snitch