class ChangeWidthdrawlsAmountToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :widthdrawls, :amount, :integer
  end
end
