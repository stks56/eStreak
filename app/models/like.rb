class Like < ApplicationRecord
  validates :post_id, presence: true, uniqueness: {scope: :user_id}
  validates :user_id, presence: true

  belongs_to :post
  counter_culture :post
  belongs_to :user
end
