require 'rails_helper'

describe 'フォロー機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@exmple.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@exmple.com') }

  context 'ユーザーAがログインしているとき' do
    let(:login_user_a) { user_a }
    let(:login_user_b) { user_b }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: login_user_a.email
      fill_in 'user[password]', with: login_user_a.password
      click_button 'ログイン'
      visit "/users/#{login_user_b.id}"
    end

    context 'ユーザーBをフォローしていないとき' do
      it 'フォローするが表示され、クリックするとフォローができる' do
        expect(page).not_to have_content 'フォロー中'
        click_link 'フォローする'
        expect(page).to have_content 'このユーザーをフォローしました！'
      end
    end

    context 'ユーザーBをフォローしているとき' do
      before do
        click_link 'フォローする'
      end

      xit 'フォロー中が表示され、クリックするとフォローが外れる' do
        expect(page).to have_content 'フォロー中'
        click_link 'フォロー中'
        expect(page).to have_content 'このユーザーのフォローを外しました...'
      end
    end
  end

  context 'ユーザーがログインしていないとき' do
    let(:login_user_a) { user_a }
    let(:login_user_b) { user_b }

    before do
      visit "/users/#{login_user_b.id}"
    end

    it 'フォローするが表示されない' do
      expect(page).not_to have_content 'フォローする'
    end
  end
end
