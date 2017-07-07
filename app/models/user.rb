class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships 
  has_many :friends, :through => :friendships
  # Reverse friendships so we can get at the other side of a relationship
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, source: :user

  has_many :posts
end
