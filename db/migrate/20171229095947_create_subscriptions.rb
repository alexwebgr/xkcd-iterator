class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :subs_name, null: false
      t.string :label
      t.string :active
      t.references :subscriber, foreign_key: true, null: false

      t.timestamps
    end
  end
end
