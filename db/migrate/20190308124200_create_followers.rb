class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.references :user
      t.references :follower

      t.timestamps
    end
    add_foreign_key :followers, :users, column: :user_id
    add_foreign_key :followers, :users, column: :follower_id
  end
end
