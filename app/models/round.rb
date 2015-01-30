class Round < ActiveRecord::Base
  # Remember to create a migration!
  has_many :guesses
end
