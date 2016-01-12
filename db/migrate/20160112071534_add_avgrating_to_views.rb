class AddAvgratingToViews < ActiveRecord::Migration
  def change
    add_column :views, :avgrating, :float
  end
end
