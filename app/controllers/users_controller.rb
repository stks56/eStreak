class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

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

  def ensure_correct_user
    if @current_user.id != params[:user_id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
end
