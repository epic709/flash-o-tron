class Deck < ActiveRecord::Base
  # Remember to create a migration!
  validates :name, uniqueness: true
  has_many :cards
  has_one :round
end
