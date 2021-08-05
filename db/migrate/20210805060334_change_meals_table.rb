class ChangeMealsTable < ActiveRecord::Migration[6.0]
  def change
    change_table :meals do |t|
      t.remove :instructions, :tags, :ingredients
      t.jsonb :instructions, :tags, :ingredients
    end
  end
end
