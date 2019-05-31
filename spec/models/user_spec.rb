require 'rails_helper'

RSpec.describe User, type: :model do
  it 'ユーザー名、メールアドレス、パスワードが有効であること' do
    user = User.create(
      name: 'テストユーザー',
      email: 'test@example.com',
      password: 'testpassword'
    )
    expect(user).to be_valid
  end

  it 'ユーザー名がなければ無効であること' do
    user = User.create(name: nil)
    user.valid?
    expect(user.errors[:name]).to include 'を入力してください'
  end

  it 'メールアドレスがなければ無効であること' do
    user = User.create(email: nil)
    user.valid?
    expect(user.errors[:email]).to include 'を入力してください'
  end

  it 'メールアドレスは「@」が入っていること' do
    user = User.create(email: 'testexample.com')
    user.valid?
    expect(user.errors[:password]).to include 'を入力してください'
  end

  it 'パスワードがなければ無効であること' do
    user = User.create(password: nil)
    user.valid?
    expect(user.errors[:password]).to include 'を入力してください'
  end

  it 'パスワードは6文字以上であること' do
    user = User.create(password: '12345')
    user.valid?
    expect(user.errors[:password]).to include 'は6文字以上で入力してください'
  end
end
