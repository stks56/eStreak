ActiveAdmin.register User do
  permit_params :name,:email, :image_name, :password, posts_attributes: [:title, :content], likes_attributes: [:post, :user], followers_attributes: [:user, :follower]
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
