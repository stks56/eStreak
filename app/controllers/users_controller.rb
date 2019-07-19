class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
                 .page(params[:page])
                 .per(10).order('created_at desc')
    follows = Follower.where(user_id: params[:id]).pluck(:follower_id)
    @user_follows = User.where(id: follows)
    @user_followers = Follower.where(follower_id: params[:id]).includes(:user)
    @followed_flag = Follower.find_by(user_id: current_user.id, follower_id: @user.id)
  end
end
