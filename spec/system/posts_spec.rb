require 'rails_helper'

describe '記事管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@exmple.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@exmple.com') }
  let!(:game_a) { FactoryBot.create(:game, name: 'ゲームA') }
  let!(:post_a) { FactoryBot.create(:post, title: '最初の記事のタイトル', content: '最初の記事の内容', game: game_a, user: user_a) }

  shared_examples_for 'ユーザーAが作成した記事のタイトルが表示される' do
    it { expect(page).to have_content '最初の記事のタイトル' }
  end

  shared_examples_for 'ユーザーAが作成した記事の内容が表示される' do
    it { expect(page).to have_content '最初の記事の内容' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit login_path
        fill_in 'email', with: login_user.email
        fill_in 'password', with: login_user.password
        click_button 'ログイン'
        visit posts_path
      end

      it_behaves_like 'ユーザーAが作成した記事のタイトルが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      before do
        visit login_path
        fill_in 'email', with: login_user.email
        fill_in 'password', with: login_user.password
        click_button 'ログイン'
        visit posts_path
      end

      it_behaves_like 'ユーザーAが作成した記事のタイトルが表示される'
    end

    context 'ログインしていないとき' do
      before do
        visit posts_path
      end

      it_behaves_like 'ユーザーAが作成した記事のタイトルが表示される'
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit login_path
        fill_in 'email', with: login_user.email
        fill_in 'password', with: login_user.password
        click_button 'ログイン'
        visit posts_path
        click_link '最初の記事のタイトル'
      end

      it_behaves_like 'ユーザーAが作成した記事の内容が表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      before do
        visit login_path
        fill_in 'email', with: login_user.email
        fill_in 'password', with: login_user.password
        click_button 'ログイン'
        visit posts_path
        click_link '最初の記事のタイトル'
      end

      it_behaves_like 'ユーザーAが作成した記事の内容が表示される'
    end

    context 'ログインしていないとき' do
      before do
        visit posts_path
        click_link '最初の記事のタイトル'
      end

      it_behaves_like 'ユーザーAが作成した記事の内容が表示される'
    end
  end

  describe '新規投稿機能' do
    let(:login_user) { user_a }
    let(:post_title) { '新規投稿機能用のタイトル' }
    let(:post_content) { '新規投稿機能用の内容' }

    context 'ユーザーがログインしているとき' do
      before do
        visit login_path
        fill_in 'email', with: login_user.email
        fill_in 'password', with: login_user.password
        click_button 'ログイン'
        visit 'posts/new'
      end

      it '記事投稿画面にアクセスできる' do
        expect(page).to have_content '投稿する'
      end

      context '記事投稿画面でタイトルと内容を入力したとき' do
        before do
          visit 'posts/new'
          fill_in 'title', with: post_title
          fill_in 'content', with: post_content
          click_button '投稿'
        end

        it '投稿が成功し、投稿一覧画面へリダイレクトされる' do
          within '.flash' do
            expect(page).to have_content '記事を投稿しました'
          end
          expect(current_path).to eq(posts_path)
        end
      end

      context '記事投稿画面でタイトルだけを入力したとき' do
        before do
          visit 'posts/new'
          fill_in 'title', with: post_title
          click_button '投稿'
        end

        it '投稿が失敗し、エラーメッセージが表示される' do
          expect(page).to have_content 'Contentを入力してください'
        end
      end

      context '記事投稿画面で内容だけを入力したとき' do
        before do
          visit 'posts/new'
          fill_in 'content', with: post_content
          click_button '投稿'
        end

        it '投稿が失敗し、エラーメッセージが表示される' do
          expect(page).to have_content 'Titleを入力してください'
        end
      end
    end

    context 'ユーザーがログインしていないとき' do
      before do
        visit 'posts/new'
      end

      it '記事投稿画面にアクセスできず、ログイン画面にリダイレクトする' do
        within '.flash' do
          expect(page).to have_content 'ログインが必要です'
        end
        expect(current_path).to eq(login_path)
      end
    end
  end

  describe '記事編集機能' do
    let(:post_title) { '記事編集機能用のタイトル' }
    let(:post_content) { '記事編集機能用の内容' }

    shared_examples_for 'ユーザーAが編集した記事のタイトルが表示される' do
      it { expect(page).to have_content '記事編集機能用のタイトル' }
    end

    shared_examples_for 'ユーザーAが編集した記事の内容が表示される' do
      it { expect(page).to have_content '記事編集機能用のタイトル' }
    end

    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit login_path
        fill_in 'email', with: login_user.email
        fill_in 'password', with: login_user.password
        click_button 'ログイン'
        visit 'posts'
        click_link '最初の記事のタイトル'
      end

      it '編集ボタンが表示される' do
        expect(page).to have_content '編集'
      end

      it '編集ボタンをクリックすると編集画面が表示される' do
        click_link '編集'
        expect(current_path).to include 'edit'
      end

      context '記事編集画面でタイトルと内容を入力したとき' do
        before do
          click_link '編集'
          fill_in 'title', with: post_title
          fill_in 'content', with: post_content
          click_button '編集'
        end

        it '編集が成功し、記事詳細画面へリダイレクトされる' do
          within '.flash' do
            expect(page).to have_content '記事を編集しました'
          end
          expect(page).to have_content '記事編集機能用のタイトル'
          expect(page).to have_content '記事編集機能用のタイトル'
        end
      end

      context '記事編集画面でタイトルだけを入力したとき' do
        before do
          click_link '編集'
          fill_in 'title', with: post_title
          fill_in 'content', with: ''
          click_button '編集'
        end

        it '投稿が失敗し、エラーメッセージが表示される' do
          expect(page).to have_content 'Contentを入力してください'
        end
      end

      context '記事編集画面で内容だけを入力したとき' do
        before do
          click_link '編集'
          fill_in 'title', with: ''
          fill_in 'content', with: post_content
          click_button '編集'
        end

        it '投稿が失敗し、エラーメッセージが表示される' do
          expect(page).to have_content 'Titleを入力してください'
        end
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      before do
        visit login_path
        fill_in 'email', with: login_user.email
        fill_in 'password', with: login_user.password
        click_button 'ログイン'
        visit 'posts'
        click_link '最初の記事のタイトル'
      end

      it '編集ボタンが表示されない' do
        expect(page).not_to have_content '編集'
      end
    end

    context 'ログインしていないとき' do
      before do
        visit 'posts'
        click_link '最初の記事のタイトル'
      end

      it '編集ボタンが表示されない' do
        expect(page).not_to have_content '編集'
      end
    end
  end

  describe '記事削除機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit login_path
        fill_in 'email', with: login_user.email
        fill_in 'password', with: login_user.password
        click_button 'ログイン'
        visit 'posts'
        click_link '最初の記事のタイトル'
      end

      it '削除ボタンが表示される' do
        expect(page).to have_content '削除'
      end

      context '削除ボタンをクリックしたとき' do
        before do
          click_link '削除'
        end

        xit '記事が削除され、記事一覧表示画面にリダイレクトされる' do
          within '.flash' do
            expect(page).to have_content '記事を削除しました'
          end
          expect(current_path).to eq(posts_path)
          expect(page).not_to have_content '最初の記事のタイトル'
        end
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      before do
        visit login_path
        fill_in 'email', with: login_user.email
        fill_in 'password', with: login_user.password
        click_button 'ログイン'
        visit 'posts'
        click_link '最初の記事のタイトル'
      end

      it '削除ボタンが表示されない' do
        expect(page).not_to have_content '削除'
      end
    end

    context 'ログインしていないとき' do
      before do
        visit 'posts'
        click_link '最初の記事のタイトル'
      end

      it '削除ボタンが表示されない' do
        expect(page).not_to have_content '削除'
      end
    end
  end
end
