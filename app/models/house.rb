class House < ApplicationRecord
  has_many :games

  has_many :games_as_user_house, class_name: 'Game', foreign_key: "user_house_id"
  has_many :computers, through: :games_as_user_house, source: :computer

  has_many :games_as_computer_house, class_name: 'Game', foreign_key: "computer_house_id"
  has_many :users, through: :games_as_computer_house, source: :users

  accepts_nested_attributes_for :games

  def talk_to_house_ghost
    if self.name == "Ravenclaw"
      @quotes = ["If you have to ask, you\'ll never know. If you know, you need only ask.", "Go away, I'm reading!", "I do not anwer to that name"]
      @quotes.sample
    elsif self.name == "Gryffindor"
      @quotes = ["Once again, you show all the sensitivity of a blunt axe.", "But you would think, wouldn't you, that getting hit forty-five times in the neck with a blunt axe would qualify you to join the Headless Hunt?", "Half an inch of skin and sinew holding my neck on! Most people would think that's good and beheaded, but oh no, it's not enough for Sir Properly Decapitated-Podmore."]
      @quotes.sample 
    elsif self.name == "Hufflepuff"
      @quotes = ["Forgive and forget, I say, we ought to give Peeves a second chance!", "Go away, I'm eating!"]
      @quotes.sample
    else
      @quotes = ["I'm busy dealing with Peeves right now. Go away."]
      @quotes.sample
    end
  end

end


