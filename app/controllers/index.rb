enable :sessions

get '/' do
  # @all_posts = Post.order('created_at DESC').all
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
  session[:cur_deck] = Deck.where(id: params[:d_id]).first.name
# puts "DECK NUMBER: #{params[:d_id]}"
  # #create a round
  a_round = Round.create(deck_id: params[:d_id], user_id: session[:user_id])
# puts "ROUND #{a_round}"
  # #retrieve cards
  deck_of_cards = Card.where(deck_id: params[:d_id])
  # #populate guesses (WHY NEED TO FIDDLE WITH GUESSES?)
  deck_of_cards.each do |card|
    @round_of_guesses = Guess.create(card_id: card.id)
  end
puts Guess.count
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