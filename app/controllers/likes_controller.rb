class LikesController < ApplicationController
before_action :authenticate_user!, {only: [:create, :destroy]}

  def index
    like_ranks = Like.group(:post_id).order(Arel.sql("count(post_id) desc")).limit(10).pluck(:post_id)
    @posts_rank = Post.find(like_ranks)
  end

  def create
    like = Like.new(
      post_id: params[:post_id],
      user_id: @current_user.id,
      game_id: Post.find(params[:post_id]).game_id
    )
    if like.save
      flash[:notice] = "この記事をいいね！しました！"
      redirect_to("/posts/#{params[:post_id]}")
    else
      flash[:notice] = "不正なリクエストです"
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
      flash[:notice] = "不正なリクエストです"
      redirect_to("/")
    end
  end
end
