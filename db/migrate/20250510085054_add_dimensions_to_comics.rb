class AddDimensionsToComics < ActiveRecord::Migration[8.0]
  def change
    add_column :comics, :width, :integer, default: 0
    add_column :comics, :height, :integer, default: 0
  end
end
