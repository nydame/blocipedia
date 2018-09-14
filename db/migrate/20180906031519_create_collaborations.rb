class CreateCollaborations < ActiveRecord::Migration[5.2]
  def change
    create_table :collaborations do |t|
      t.references :user, foreign_key: true, null: false, default: 0
      t.references :wiki, foreign_key: true, null: false, default: 0

      t.timestamps
    end
  end
end
