class Follower < ApplicationRecord
  validates :user_id, presence: true, uniqueness: {scope: :follower_id}
  validates :follower_id, presence: true

  belongs_to :user

  class << self
    def user_follows_id_list(id:)
      where(user_id: id).pluck(:follower_id)
    end
  end
end
