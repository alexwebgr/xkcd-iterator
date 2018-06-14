class AddTokenToSubscribers < ActiveRecord::Migration[5.1]
  def change
    add_column :subscribers, :token, :string
  end
end
