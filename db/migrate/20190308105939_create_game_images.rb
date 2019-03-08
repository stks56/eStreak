class CreateGameImages < ActiveRecord::Migration[5.2]
  def change
    create_table :game_images do |t|
      t.references :game, foreign_key: true
      t.string :icon_image_name
      t.string :background_image_name

      t.timestamps
    end
  end
end
