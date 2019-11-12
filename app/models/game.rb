class Game < ApplicationRecord
  belongs_to :user, class_name: 'House', foreign_key: 'user_house_id'
  belongs_to :computer, class_name: 'House', foreign_key: 'computer_house_id'

  has_many :turns

end
