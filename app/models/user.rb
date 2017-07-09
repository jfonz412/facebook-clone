class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name, presence: true, length: { minimum: 2, maximum: 35 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships 
  has_many :friends, :through => :friendships
  # Reverse friendships so we can get at the other side of a relationship
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, source: :user

  has_many :posts

  # returns an array of both friends and inverse friends
  def all_friends 
    all_friends = []
    self.friends.each do |friend|
      all_friends << friend
    end
    self.inverse_friends.each do |friend|
      all_friends << friend
    end
    all_friends
  end 

  def feed
    Post.where("user_id IN (?) OR user_id = ?", all_friends, self)
  end
end
