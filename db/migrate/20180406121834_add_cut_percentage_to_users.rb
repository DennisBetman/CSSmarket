class AddCutPercentageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cut_percentage, :decimal, default: 0.8
  end
end
