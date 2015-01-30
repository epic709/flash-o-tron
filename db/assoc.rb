
Post.all.each do |post|
  array = Tag.all
  3.times do
    sample = array.sample
    post.tags << sample
    array.delete(sample)
  end
end

