class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  # associate an image with this model through ImageUploader
  mount_uploader :image, ImageUploader 

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 8000 }
  validate  :image_size

  belongs_to :user
  has_many   :likes,    dependent: :destroy
  has_many   :comments, dependent: :destroy
  
  def formatted_date
		created_at.strftime("%m/%d/%Y %H:%M%P")
	end

  private
      # Validates the size of an uploaded picture.
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    end
end
