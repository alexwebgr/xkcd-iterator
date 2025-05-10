class AddMejorToSubscribers < ActiveRecord::Migration[8.0]
  def change
    rename_column :subscribers, :super, :mejor
  end
end
