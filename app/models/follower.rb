class Follower < ApplicationRecord
  validates :user_id, presence: true, uniqueness: {scope: :follower_id}
  validates :follower_id, presence: true

  belongs_to :user
end
