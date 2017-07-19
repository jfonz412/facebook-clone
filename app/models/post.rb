class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  # associate an image with this model through ImageUploader
  mount_uploader :image, ImageUploader 

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 8000 }

  belongs_to :user
  has_many   :likes,    dependent: :destroy
  has_many   :comments, dependent: :destroy
  
  def formatted_date
		created_at.strftime("%m/%d/%Y %H:%M%P")
	end
end
