class RenameWidthdrawlsToWithdrawals < ActiveRecord::Migration[5.0]
  def change
     rename_table :widthdrawls, :withdrawals
   end
end
