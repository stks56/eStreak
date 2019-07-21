class Follower < ApplicationRecord
  validates :user_id, presence: true, uniqueness: {scope: :follower_id}
  validates :follower_id, presence: true

  belongs_to :user

  class << self
    def user_follows_list(user_id:)
      follower_ids = where(user_id: user_id).pluck(:follower_id)
      User.where(id: follower_ids)
    end
  end
end
