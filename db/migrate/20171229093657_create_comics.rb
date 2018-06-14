class CreateComics < ActiveRecord::Migration[5.1]
  def change
    create_table :comics do |t|
      t.integer :num
      t.string :title, null: false
      t.string :safe_title, null: false
      t.string :img_url, null: false
      t.text :alt_text
      t.string :day
      t.string :month
      t.string :year
      t.text :transcript

      t.timestamps
    end
  end
end
