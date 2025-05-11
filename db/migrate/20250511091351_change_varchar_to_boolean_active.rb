class ChangeVarcharToBooleanActive < ActiveRecord::Migration[8.0]
  def change
    change_column :subscriptions, :active,"boolean USING CAST(active AS boolean)"
    change_column_default :subscriptions, :active, false
  end
end
