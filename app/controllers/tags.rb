get '/tags/:tag' do
  @all_posts = []
  Post.all.each do |post|
    if post.tag_list.include?(params[:tag])
      @all_posts << post
    end
  end
  erb :tags
end