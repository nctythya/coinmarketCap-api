class AddNameToCryptos < ActiveRecord::Migration[7.0]
  def change
    add_column :cryptos, :name, :string
  end
end
