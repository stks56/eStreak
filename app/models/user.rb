class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password, {presence: true}
  validates :image, {presence: true}

  mount_uploader :image, ImageUploader

  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :posts
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :likes
  has_many :followers, dependent: :destroy
  accepts_nested_attributes_for :followers

  has_secure_password
end
