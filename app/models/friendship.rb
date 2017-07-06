class Friendship < ApplicationRecord
	belongs_to :user
	belongs_to :friend, class_name: "User"

	validates :user_id,   presence: true
	validates :friend_id, presence: true

	scope :pending, -> { where(:accepted => false) }
	scope :accepted, -> { where(:accepted => true) }
end
