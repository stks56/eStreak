class LikesController < ApplicationController
before_action :authenticate_user

  def create
    like = Like.new(
      post_id: params[:post_id],
      user_id: @current_user.id
    )
    if like.save
      flash[:notice] = "この記事をいいね！しました！"
      redirect_to("/posts/#{params[:post_id]}")
    else
      flash[:notice] = "不正なリクエストです(いいね機能)"
      redirect_to("/")
    end
  end

  def destroy
    like = Like.find_by(
      post_id: params[:post_id],
      user_id: @current_user.id
    )
    if like.destroy
      flash[:notice] = "この記事のいいね！を外しました..."
      redirect_to("/posts/#{params[:post_id]}")
    else
      flash[:notice] = "不正なリクエストです(いいね機能)"
      redirect_to("/")
    end
  end
end
