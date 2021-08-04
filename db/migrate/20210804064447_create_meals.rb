class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.string :title
      t.string :category
      t.string :area
      t.text :instructions
      t.binary :image
      t.string :tags
      t.string :ingredients
      t.string :source

      t.timestamps
    end
  end
end
