class ChangeColumnTogameimage < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key 'game_images', 'games'
  end
end
