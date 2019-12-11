class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.float :last_price
      t.float :change
      t.float :percentage_change
      t.integer :market_cap

      t.timestamps
    end
  end
end
