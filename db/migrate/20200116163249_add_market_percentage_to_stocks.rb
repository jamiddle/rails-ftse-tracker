class AddMarketPercentageToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :market_percentage, :float
  end
end
