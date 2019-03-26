class AddGameIdColumnFromLikes < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :game_id, :integer
  end
end
