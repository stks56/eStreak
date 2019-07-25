class User < ApplicationRecord
  validates :name, presence: true
  validate :test_user_is_unchangeable
  before_destroy :test_user_is_not_deletable

  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :posts
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :likes
  has_many :followers, dependent: :destroy
  accepts_nested_attributes_for :followers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :lockable,
         :timeoutable, :omniauthable, omniauth_providers: [:twitter, :twitch]

  mount_uploader :image, ImageUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.nickname
      user.username = auth.info.name
      user.remote_image_url = auth.info.image
    end
  end

  private

  def test_user_is_unchangeable
    errors.add(:base, 'テストユーザーの情報は変更できません') if test_user?
  end

  def test_user_is_not_deletable
    throw :abort if test_user?
  end

  def test_user?
    self == User.find_by(email: 'test@e-streak.com')
  end
end
