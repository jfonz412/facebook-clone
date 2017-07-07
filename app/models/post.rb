class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 8000 }
  belongs_to :user
end
