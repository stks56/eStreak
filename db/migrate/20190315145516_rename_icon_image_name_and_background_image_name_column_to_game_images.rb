class RenameIconImageNameAndBackgroundImageNameColumnToGameImages < ActiveRecord::Migration[5.2]
  def change
    rename_column :game_images, :icon_image_name, :icon_image
    rename_column :game_images, :background_image_name, :background_image
  end
end
