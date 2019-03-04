class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true}
  validates :password, {presence: true}
  validates :image_name, {presence: true}
end
