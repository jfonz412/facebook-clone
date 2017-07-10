class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name, presence: true, length: { minimum: 2, maximum: 35 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :likes
  
  has_many :friends,         -> { where("accepted = ?", true) }, :through => :friendships
  has_many :inverse_friends, -> { where("accepted = ?", true) }, :through => :inverse_friendships, source: :user
  
  has_many :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :pending_friends,         -> { where("accepted = ?", false) }, :through => :friendships, source: :friend
  has_many :inverse_pending_friends, -> { where("accepted = ?", false) }, :through => :inverse_friendships, source: :user
  

  # Returns an array of both friends and inverse friends
  def all_friends 
    friends = []
    self.friends.each do |friend|
      friends << friend
    end
    self.inverse_friends.each do |friend|
      friends << friend
    end
    friends
  end 

  # Returns an array including pending requests for users#index
  def all_friends_including_pending
    friends = []
    self.pending_friends.each do |friend|
      friends << friend
    end
    self.inverse_pending_friends.each do |friend|
      friends << friend
    end
    friends + all_friends
  end 

  def feed
    Post.where("user_id IN (?) OR user_id = ?", all_friends, self)
  end
end
