class CreateWikis < ActiveRecord::Migration[5.2]
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
      t.boolean :private?
      t.timestamps
    end
  end
end
