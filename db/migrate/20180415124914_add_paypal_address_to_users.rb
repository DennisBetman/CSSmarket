class AddPaypalAddressToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :paypal_address, :string
  end
end
