require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
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

  describe 'テストユーザーの変更制限' do
    let(:test_user) { FactoryBot.create(:user, email: 'test@e-streak.com') }
    let(:general_user) { FactoryBot.create(:user, email: 'alice@e-streak.com') }

    it 'テストユーザーは情報を変更できない' do
      test_user.update(email: 'test2@e-streak.com')
      expect(test_user.errors[:base]).to include 'テストユーザーの情報は変更できません'
    end

    it 'テストユーザー以外は情報を変更できる' do
      general_user.update(email: 'alice2@e-streak.com')
      expect(general_user.errors[:base]).not_to include 'テストユーザーの情報は変更できません'
    end

    it 'テストユーザーは削除されない' do
      test_user.destroy
      expect(test_user).to eq User.find_by(email: 'test@e-streak.com')
    end

    it 'テストユーザー以外は削除される' do
      general_user.destroy
      expect(general_user).not_to eq User.find_by(email: 'alice@e-streak.com')
    end
  end
end
