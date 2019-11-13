class House < ApplicationRecord
  has_many :games

  has_many :games_as_user_house, class_name: 'Game', foreign_key: "user_house_id"
  has_many :computers, through: :games_as_user_house, source: :computer

  has_many :games_as_computer_house, class_name: 'Game', foreign_key: "computer_house_id"
  has_many :users, through: :games_as_computer_house, source: :users

  accepts_nested_attributes_for :games

end


