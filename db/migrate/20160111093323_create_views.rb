class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.string :name
      t.integer :movId
      t.date :year
      t.string :photo
      t.string :overview

      t.timestamps null: false
    end
  end
end
