class PostsController < ApplicationController
  def index
    @posts = Post.all.order("created_at desc").limit(20)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end
end
