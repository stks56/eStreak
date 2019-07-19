class PostsController < ApplicationController
  before_action :authenticate_user!, {only: [:new, :create, :edit, :update, :destroy]}
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.page(params[:page]).per(10).order('created_at desc')
  end

  def show
    @post = Post.find_by(id: params[:id])
    @liked_flag = Like.find_by(post_id: @post.id, user_id: current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = '記事を投稿しました'
      redirect_to('/posts')
    else
      render('posts/new')
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = '記事を編集しました'
      redirect_to("/posts/#{@post.id}")
    else
      render('posts/edit')
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = '記事を削除しました'
    redirect_to('/posts')
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if current_user.id != @post.user_id
      flash[:notice] = '権限がありません'
      redirect_to('/')
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :game_id, :content)
  end
end
