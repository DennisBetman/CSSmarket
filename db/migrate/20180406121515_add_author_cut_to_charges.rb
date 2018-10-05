class AddAuthorCutToCharges < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :author_cut, :decimal
  end
end
