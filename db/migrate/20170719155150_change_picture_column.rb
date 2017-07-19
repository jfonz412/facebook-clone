class ChangePictureColumn < ActiveRecord::Migration[5.0]
  def change
  	remove_column :posts, :picture
  	add_column    :posts, :image, :string
  end
end
