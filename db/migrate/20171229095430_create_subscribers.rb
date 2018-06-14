class CreateSubscribers < ActiveRecord::Migration[5.1]
  def change
    create_table :subscribers do |t|
      t.string :firstname
      t.string :email, null: false
      t.boolean :verified
      t.boolean :super, default: false

      t.timestamps
    end
  end
end
