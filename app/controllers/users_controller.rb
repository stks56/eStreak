class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
                 .page(params[:page])
                 .per(10)
                 .order('created_at desc')
                 .includes(:user, :game)
    @user_follows = Follower.user_follows_list(user_id: params[:id])
    @user_followers = Follower.where(follower_id: params[:id]).includes(:user)
    if user_signed_in?
      @followed_flag = Follower.find_by(
        user_id: current_user.id,
        follower_id: @user.id
      )
    end
  end
end
