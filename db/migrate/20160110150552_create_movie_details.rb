class CreateMovieDetails < ActiveRecord::Migration
  def change
    create_table :movie_details do |t|
      t.string :uName
      t.integer :movId
      t.integer :rate
      t.string :review

      t.timestamps null: false
    end
  end
end
