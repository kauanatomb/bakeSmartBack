class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.float :quantity, null: false
      t.string :brand, null: false
      t.references :category, foreign_key: true
      t.references :measurement_unit, foreign_key: true
      t.float :price, null: false
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
