class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :subscriber, foreign_key: true, null: false
      t.references :comic, foreign_key: true, null: false

      t.timestamps
    end
  end
end
