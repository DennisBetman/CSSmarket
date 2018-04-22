class CreateDeclinedPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :declined_posts do |t|
      t.integer :post_id
      t.text :description

      t.timestamps
    end
  end
end
