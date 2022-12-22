class AddPriceAndTotalValueToCryptos < ActiveRecord::Migration[7.0]
  def change
    add_column :cryptos, :price, :decimal
    add_column :cryptos, :total_value, :decimal
  end
end
