class User < ApplicationRecord
  belongs_to :house
  has_secure_password
  validates :username, presence: true, uniqueness: true
end
