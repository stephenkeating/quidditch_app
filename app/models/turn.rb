class Turn < ApplicationRecord
  belongs_to :game

  validate :energy_error 

  
  def energy_error
    
    errors.add(:user_energy, "You must use exactly #{user_energy} energy this turn.") unless (user_quaffle_allocation + user_bludger_allocation + user_snitch_allocation) == user_energy
  
  end

  # def user_energy_pt #getting called on new turn page
  #   if self.game.turns.count == 1
  #     self.update(user_energy: 10)
  #   else
  #     self.update(user_energy: (10 + (Turn.where(id: ((self.id) - 1))[0].user_bludger_outcome)))
  #   end
  # end

  def comp_energy_pt
    
    if self.game.turns.count == 1
      self.update(computer_energy: 10)
    else
      self.update(computer_energy: (10 + (Turn.where(id: ((self.id) - 1))[0].computer_bludger_outcome)))
    end
  end
  
  def computer_energy_array #removing .shuffle & rearranging the variables on the next method is how we could determine how houses prioritize energy distribution
    comp_energy_pt
    a = []
    a << first_integer = rand(0..(self.computer_energy))
    a << second_integer = rand(0..((self.computer_energy) - first_integer))
    a << (self.computer_energy) - (first_integer + second_integer)
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

  def generate_comparison_values  #think later if 5 is a good starting max range for Q/B and 3 for S
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
      self.update(user_score: 10)
      self.update(computer_score: 0)
      p "user scored"
    elsif @computer_quaffle_value > @user_quaffle_value
      self.update(user_score: 0)
      self.update(computer_score: 10)
      p "computer scored"
    else 
      self.update(user_score: 0)
      self.update(computer_score: 0)
      p "no one scored"
    end

    if @user_bludger_value > @computer_bludger_value
      self.update(user_bludger_outcome: 5)
      self.update(computer_bludger_outcome: -2)
      p "user bludgered"
    elsif @computer_bludger_value > @user_bludger_value
      self.update(user_bludger_outcome: -2)
      self.update(computer_bludger_outcome: 5)
      p "computer bludgered"
    else 
      self.update(user_bludger_outcome: 0)
      self.update(computer_bludger_outcome: 0)
      p "no one bludgered"
    end

    if @user_snitch_value > @computer_snitch_value
      p "user went for the snitch"
      p @user_snitch_value
      p @computer_snitch_value
      self.update(user_snitch_chance: (@user_snitch_value - @computer_snitch_value))
      self.update(computer_snitch_chance: 0)
      
      x = self.game.turns.calculate(:sum, :user_snitch_chance)
      p x
      snitch_odds = rand(1..x)

      r = rand(5..100)

      if snitch_odds > r
        # unsure if += works here
        self.update(user_score: (self.user_score + 150))
        p "user caught snitch"
        #trigger game over logic
      end


    elsif @computer_snitch_value > @user_snitch_value
      p "computer went for the snitch"
      self.update(computer_snitch_chance: (@computer_snitch_value - @user_snitch_value))
      self.update(user_snitch_chance: 0)

      x = self.game.turns.calculate(:sum, :computer_snitch_chance)

      snitch_odds = rand(1..x)

      r = rand(5..100)
      
      if snitch_odds > r
        # unsure if += works here
        self.update(computer_score: (self.computer_score + 150))
        p "computer caught snitch"
        #trigger game over logic
      end
    else 
      self.update(user_snitch_chance: 0)
      self.update(computer_snitch_chance: 0)
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


# method to calculate sum of a column in an active record table: 
# calculate(operation, column_name)
# self.game.turns.calculate(:sum, :user_snitch_chance)

# to update an attribute on an active record instance:
# instance.update(key: value)