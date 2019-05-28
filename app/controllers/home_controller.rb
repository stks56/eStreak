class HomeController < ApplicationController
  def top
    redirect_to("/users/#{current_user.id}") if user_signed_in?
  end
end
