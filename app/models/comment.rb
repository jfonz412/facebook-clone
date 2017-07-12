class Comment < ApplicationRecord
	validates :content, presence: true
  belongs_to :user
  belongs_to :post

  def formatted_date
		created_at.strftime("%m/%d/%Y %H:%M%P")
	end
end
