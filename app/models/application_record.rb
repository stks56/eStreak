class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def user
    return User.find_by(id: self.user_id)
  end

  def game
    return Game.find_by(id: self.game_id)
  end

  def posts
    return Post.where(user_id: self.id).order("created_at desc")
  end

  def likecount
    return Like.where(post_id: self.id).count(:user_id)
  end
end
