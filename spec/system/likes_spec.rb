require 'rails_helper'

describe 'いいね機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@exmple.com') }
  let!(:game_a) { FactoryBot.create(:game, name: 'ゲームA') }
  let!(:post_a) { FactoryBot.create(:post, title: '最初の記事のタイトル', content: '最初の記事の内容', game: game_a, user: user_a) }

  context 'ユーザーがログインしているとき' do
    let(:login_user) { user_a }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: login_user.email
      fill_in 'user[password]', with: login_user.password
      click_button 'ログイン'
      visit posts_path
      click_link '最初の記事のタイトル'
    end

    it 'いいねするが表示され、クリックするといいねができる' do
      expect(page).to have_content 'いいねする！'
      click_link 'いいねする！'
      within '.flash' do
        expect(page).to have_content 'この記事をいいね！しました！'
      end
    end

    before do
      click_link 'いいねする！'
    end

    it 'いいねした！が表示され、クリックするといいねが外れる' do
      expect(page).to have_content 'いいねした！'
      click_link 'いいねした！'
      within '.flash' do
        expect(page).to have_content 'この記事のいいね！を外しました...'
      end
    end
  end

  context 'ユーザーがログインしていないとき' do
    before do
      visit posts_path
      click_link '最初の記事のタイトル'
    end

    it 'いいねをするにはログインが必要ですと表示され、クリックするとログイン画面に飛ばされる' do
      expect(page).to have_content 'いいねをするにはログインが必要です'
      click_link 'いいねをするにはログインが必要です'
      expect(current_path).to eq new_user_session_path
    end
  end
end
