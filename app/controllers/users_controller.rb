class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update, :logout]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      image_name: "default_user.jpg"
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録に成功しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def show
    @user = User.find_by(id: params[:user_id])
  end

  def edit
    @user = User.find_by(id: params[:user_id])
  end

  def update
    @user = User.find_by(id: params[:user_id])
    @user.name = params[:name]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_image/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/users/#{@user.id}")
    else
      @message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

  def ensure_correct_user
    if @current_user.id != params[:user_id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
end
