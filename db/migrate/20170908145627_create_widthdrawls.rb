class CreateWithdrawals < ActiveRecord::Migration[5.0]
  def change
    create_table :widthdrawls do |t|
      t.integer :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
