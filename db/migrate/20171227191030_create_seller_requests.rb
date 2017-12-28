class CreateSellerRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :seller_requests do |t|
      t.integer :user_id
      t.text :content
      t.string :portfolio_url

      t.timestamps
    end
  end
end
