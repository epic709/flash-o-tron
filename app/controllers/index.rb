# notes from Estelle
# - segregate into different controllers
# - use the URL to pass persistent data for the round e.g. deck_id. For example: /game/:deck_id/cards/card_id
# - don't rely too much on sessions[]
# - the logic could be changed so that for every card displayed, create a guess, save the results, display another card

enable :sessions
require 'byebug'

get '/' do

  erb :index
end

post '/' do
  if User.authenticate(params[:u_id], params[:u_password])
    session[:user_id] = params[:u_id]
    redirect to '/main'
  else
    redirect to '/'
  end
end

get '/main' do
  #retrieve all the decks in the db
  @decks = Deck.all

  erb :main
end

# post '/main' do
#   redirect to '/deck/#{params[:d_id]}'
# end

post '/game' do
  if ! session[:in_round]
    session[:cur_deck] = Deck.where(id: params[:d_id]).first.name
  # puts "DECK NUMBER: #{params[:d_id]}"
    # #create a round
    a_round = Round.create(deck_id: params[:d_id], user_id: session[:user_id])
  # puts "ROUND #{a_round}"
    # retrieve cards
    deck_of_cards = Card.where(deck_id: params[:d_id])
    # #populate guesses (WHY NEED TO FIDDLE WITH GUESSES?)
    deck_of_cards.each do |card|
      Guess.create(card_id: card.id, round_id: a_round.id, correct: 0, incorrect: 0)
      # Round.create_guess(card_id: card.id, round_id: a_round.id, correct: 0, incorrect: 0)
byebug
    end


    # store all the guess ids
    @round_of_guesses = Guess.where(round_id: a_round.id)
    avail_guesses = []
    @round_of_guesses.each do |guess|
      avail_guesses << guess.id
    end
    session[:guesses] = avail_guesses
    # should this be controlled here?
    session[:in_round] = true

    redirect to '/game'
  elsif session[:in_round]
byebug
    # randomly select a guess
    session[:guesses].shuffle!
    cur_guess_id = session[:guesses][0]
    # remove the guess from avail_guesses
    session[:guesses].delete_at(0)

    cur_question = Card.find(Guess.find(cur_guess_id).card_id).question
    cur_answer   = Card.find(Guess.find(cur_guess_id).card_id).answer

    redirect to "/game/#{cur_guess_id}"
  else
    puts "SOMETHING WRONG WITH SESSION[:in_round]"
  end
  # redirect to '/game/'
  # erb :game
end

get "/game/:guess_id" do
byebug
  erb :game
end




# post '/new' do
#   erb :new_post
# end

# # Creates a new post, then redirects to home
# post '/new_post' do
#   new_post = Post.create(title: params[:p_title], body: params[:p_body])
#   tag_arr = params[:p_tags].split(",")
#   tag_arr.each do |tag|
#     new_tag = Tag.create(name: tag)
#     new_post.tags << new_tag
#   end
#   redirect to '/'
# end

# # Edit form for (title)
# get "/edit/:p_id" do
#   @post = Post.find(params[:p_id])
#   @tags = ""

#   @post.tag_list.each do |tag|
#     @tags << tag + ","
#   end
#   erb :edit
# end

# # Edit form has been submitted
# post "/edit/:p_id" do
#   @post = Post.find(params[:p_id])
#   @post.update(title: params[:p_title],body: params[:p_body])
#   new_tag_arr = params[:p_tags].split(",")
#   old_tag_arr = @post.tag_list
#   tags_to_delete = old_tag_arr - new_tag_arr
#   tags_to_delete.each do |tag|
#     the_tag = Tag.where(name: "#{tag}").first
#     finally = TagsPost.where(tag_id: the_tag.id, post_id: @post.id)
#     finally.first.destroy
#   end
#   new_tag_arr.each do |tag|
#     found = Tag.where(name: "#{tag}").first
#     # create and assoc the tag if it is brand new
#     if found == []
#       new_tag = Tag.create(name: tag)
#       @post.tags << new_tag
#     end
#   end

#   redirect to '/'
# end