class User < ApplicationRecord
  after_create :welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name, presence: true, length: { minimum: 2, maximum: 35 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook] # see omni docs

  has_many :posts,    dependent: :destroy
  has_many :likes,    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notices,  dependent: :destroy

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

  def likes?(post_id)
    self.likes.each do |like|
      return true if like.post_id == post_id
    end
    return false
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

end
