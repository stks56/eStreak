class FollowerController < ApplicationController
  before_action :authenticate_user!, {only: [:create, :destroy]}
  before_action :myself_can_not_follow, {only: [:create, :destroy]}

  def create
    follower = Follower.new(
      user_id: current_user.id,
      follower_id: params[:id]
    )
    if follower.save
      flash[:notice] = 'このユーザーをフォローしました！'
      redirect_to("/users/#{params[:id]}")
    else
      flash[:notice] = '不正なリクエストです'
      redirect_to('/')
    end
  end

  def destroy
    follower = Follower.find_by(
      user_id: current_user.id,
      follower_id: params[:id]
    )
    if follower.destroy
      flash[:notice] = 'このユーザーのフォローを外しました・・・'
      redirect_to("/users/#{params[:id]}")
    else
      flash[:notice] = '不正なリクエストです'
      redirect_to('/')
    end
  end

  def myself_can_not_follow
    if current_user.id == params[:id]
      flash[:notice] = '不正なリクエストです'
      redirect_to('/')
    end
  end
end
