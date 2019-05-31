class RemoveIndexToGameImages < ActiveRecord::Migration[5.2]
  def change
    change_table :game_images do |t|
      t.remove_index "game_id"
    end
  end
end
