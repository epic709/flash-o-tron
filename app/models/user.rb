class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :rounds
  validates :user_id, uniqueness: true

  def self.authenticate(user_id, password)
    user = User.where(user_id: user_id, password: password).first
    # if (email == user.email && password == user.password)
    if user == nil then false else true end
    # else return nil; end
  end

  # def tag_list
  #   array = []
  #   self.tags.all.each do |tag|
  #     array << tag.name
  #   end
  #   return array
  # end

  # def tag_id_list
  #   array = []
  #   self.tags.all.each do |tag|
  #     array << tag.id
  #   end
  #   return array
  # end

end
