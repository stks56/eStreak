class AddLikesCountToPosts < ActiveRecord::Migration[5.2]
  def self.up
    add_column :posts, :likes_count, :integer, null: false, default: 0
    Like.counter_culture_fix_counts
  end

  def self.down
    remove_column :posts, :likes_count
  end
end
