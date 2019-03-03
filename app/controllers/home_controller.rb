class HomeController < ApplicationController
  def top
    @posts = Post.all.order("created_at desc").limit(10)
  end

  def about
  end
end
