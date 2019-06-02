ActiveAdmin.register Game do
  permit_params :name, game_image_attributes: [:icon_image, :background_image]

  form(:html => { :multipart => true }) do |f|
    f.inputs 'ゲーム名' do
      f.input :name
    end

    f.inputs "ゲーム画像", :for => [:game_image, f.object.game_image || GameImage.new(icon_image: "default.jpg", background_image: "default.jpg")] do |game_image|
      game_image.input :icon_image, :image_preview => true
      game_image.input :background_image, :image_preview => true
    end

    f.actions
  end
end
