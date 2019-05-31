class Removecolumnfollowers < ActiveRecord::Migration[5.2]
  def change
    change_table :followers do |t|
      t.remove_index "follower_id"
      t.remove_index "user_id"
    end
  end
end
