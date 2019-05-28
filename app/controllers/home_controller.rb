class HomeController < ApplicationController
  def top
    if user_signed_in?
      redirect_to("/users/#{current_user.id}")
    end
  end

  def about
  end
end
