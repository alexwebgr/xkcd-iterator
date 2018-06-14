class CreateEmailReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :email_receipts do |t|
      t.integer :num, index: true
      t.references :subscriber, foreign_key: true, null: false
      t.references :comic, foreign_key: true, null: false
      t.references :subscription, foreign_key: true, null: false

      t.timestamps
    end
  end
end
