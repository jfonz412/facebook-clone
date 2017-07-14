class ChangeTypeColumn < ActiveRecord::Migration[5.0]
  def change
  	remove_column :notices, :type
  	add_column    :notices, :notice_type, :string
  end
end
