class User < ApplicationRecord
  belongs_to :house, optional: true
  has_secure_password
  validates :username, presence: true, uniqueness: true

  def sorting_hat
    answers = []
    if self.answer_one == "Ordinary"
      self.house_id = House.find_by(name: "Slytherin").id
      answers << "Slytherin"
    elsif self.answer_one == "Ignorant"
      self.house_id = House.find_by(name: "Ravenclaw").id
      answers << "Ravenclaw"
    elsif self.answer_one == "Cowardly"
      self.house_id = House.find_by(name: "Gryffindor").id
      answers << "Gryffindor"
    elsif self.answer_one == "Selfish"
      self.house_id = House.find_by(name: "Hufflepuff").id
      answers << "Hufflepuff"
    end

    if self.answer_two == "Glory"
      self.house_id = House.find_by(name: "Gryffindor").id
      answers << "Gryffindor"
    elsif self.answer_two == "Wisdom"
      self.house_id = House.find_by(name: "Ravenclaw").id
      answers << "Ravenclaw"
    elsif self.answer_two == "Love"
      self.house_id = House.find_by(name: "Hufflepuff").id
      answers << "Hufflepuff"
    elsif self.answer_two == "Power"
      self.house_id = House.find_by(name: "Slytherin").id
      answers << "Slytherin"
    end

    if self.answer_three == "Attempt to confuse the troll into letting all three of you pass without fighting"
      self.house_id = House.find_by(name: "Ravenclaw").id
      answers << "Ravenclaw"
    elsif self.answer_three == "Suggest drawing lots to decide which of you will fight"
      self.house_id = House.find_by(name: "Slytherin").id
      answers << "Slytherin"
    elsif self.answer_three == "Suggest that all three of you fight together"
      self.house_id = House.find_by(name: "Hufflepuff").id
      answers << "Hufflepuff"
    elsif self.answer_three == "Volunteer to fight by yourself"
      self.house_id = House.find_by(name: "Gryffindor").id
      answers << "Gryffindor"
    end

    if self.answer_four == "The wide, sunny, grassy lane"
      self.house_id = House.find_by(name: "Hufflepuff").id
      answers << "Hufflepuff"
    elsif self.answer_four == "The narrow, dark, lantern-lit alley"
      self.house_id = House.find_by(name: "Slytherin").id
      answers << "Slytherin"
    elsif self.answer_four == "The twisting, leaf-strewn path through woods"
      self.house_id = House.find_by(name: "Gryffindor").id
      answers << "Gryffindor"
    elsif self.answer_four == "The cobbled street lined with ancient buildings"
      self.house_id = House.find_by(name: "Ravenclaw").id
      answers << "Ravenclaw"
    end

    if self.answer_five == "Ask what makes them think so"
      self.house_id = House.find_by(name: "Hufflepuff").id
      answers << "Hufflepuff"
    elsif self.answer_five == "Agree, and ask whether they'd like a free sample of a jinx"
      self.house_id = House.find_by(name: "Gryffindor").id
      answers << "Gryffindor"
    elsif self.answer_five == "Agree, and walk away, leaving them to wonder whether you are bluffing"
      self.house_id = House.find_by(name: "Slytherin").id
      answers << "Slytherin"
    elsif self.answer_five == "Tell them that you are worried about their mental health, and offer to call a doctor"
      self.house_id = House.find_by(name: "Ravenclaw").id
      answers << "Ravenclaw"
    end
    
   house = answers.max_by{|answer| answers.count(answer)}
   house_id = House.find_by(name: house).id
   self.update(house_id: house_id)

  end

end
