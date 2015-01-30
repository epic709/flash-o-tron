class Guess < ActiveRecord::Base
  # Remember to create a migration!
  has_one :card
end
