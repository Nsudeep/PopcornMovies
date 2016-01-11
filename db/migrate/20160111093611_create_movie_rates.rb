class CreateMovieRates < ActiveRecord::Migration
  def change
    create_table :movie_rates do |t|
      t.string :uId
      t.string :uName
      t.integer :movId
      t.integer :rate
      t.string :review
      t.references :view, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
