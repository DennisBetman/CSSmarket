class AddStatusToWithdrawals < ActiveRecord::Migration[5.0]
  def change
    add_column :withdrawals, :status, :integer, default: 0
  end
end
