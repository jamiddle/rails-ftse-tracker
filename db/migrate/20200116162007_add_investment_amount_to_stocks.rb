class AddInvestmentAmountToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :investment_amount, :float
  end
end
