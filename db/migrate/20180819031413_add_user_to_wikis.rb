class AddUserToWikis < ActiveRecord::Migration[5.2]
  def change
    add_column :wikis, :user_id, :intger
    add_index :wikis, :user_id
  end
end
