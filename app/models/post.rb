class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 8000 }

  belongs_to :user
  has_many   :likes
  
  def formatted_date
		created_at.strftime("%m/%d/%Y %H:%M%P")
	end
end
