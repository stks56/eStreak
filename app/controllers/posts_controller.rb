class PostsController < ApplicationController
  def index
    @posts = Post.all.order("created_at desc").limit(20)
  end
end
