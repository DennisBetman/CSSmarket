class CreatePasswordResets < ActiveRecord::Migration[5.0]
  def change
    create_table :password_resets do |t|
      t.string :reset_id
      t.integer :user_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
