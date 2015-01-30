require_relative '../app/models/card'
require_relative '../app/models/user'

#create default user
User.create(user_id: 'pi', password: 'raspberry')

#load up the cards and associate to individual decks
filename = File.dirname(__FILE__) + "/english-malaysian.txt"
@cards_arr = File.open(filename, "r") { |f| f.read.split("\n") }

deck_name = "English to Malay"
a_deck = Deck.create(name: deck_name)

if a_deck.id != nil
  @cards_arr.each do |c|
    a_card = c.split("\t")
    Card.create(question: a_card[0], answer: a_card[1], deck_id: a_deck.id)
  end
end

filename = File.dirname(__FILE__) + "/english-filipino.txt"
@cards_arr = File.open(filename, "r") { |f| f.read.split("\n") }

deck_name = "English to Filipino"
a_deck = Deck.create(name: deck_name)

if a_deck.id != nil
  @cards_arr.each do |c|
    a_card = c.split("\t")
    Card.create(question: a_card[0], answer: a_card[1], deck_id: a_deck.id)
  end
end