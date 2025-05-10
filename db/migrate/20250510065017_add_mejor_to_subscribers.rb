class AddMejorToSubscribers < ActiveRecord::Migration[8.0]
  def change
    if column_exists?(:subscribers, :super)
      rename_column :subscribers, :super, :mejor
    end
  end
end
