class AddNiceUrlToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :nice_url, :string
  end
end
