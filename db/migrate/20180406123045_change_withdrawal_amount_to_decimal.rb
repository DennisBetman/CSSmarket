class ChangeWithdrawalAmountToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :withdrawals, :amount, :decimal
  end
end
