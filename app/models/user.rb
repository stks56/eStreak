class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password, {presence: true}
  validates :image_name, {presence: true}

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :follower, dependent: :destroy
  
  has_secure_password
end
