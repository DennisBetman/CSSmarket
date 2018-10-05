class AddNanoAddresstoUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nano_address, :string
  end
end
