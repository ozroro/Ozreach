require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  let(:user_recruiter) { FactoryBot.create(:recruiter, email: 'recruiter@test.com') }
  let(:user_seeker) { FactoryBot.create(:seeker, email: 'seeker@test.com') }
  let!(:article_a) { FactoryBot.create(:article, title: 'Railsプログラマー募集', user: user_recruiter) }

  before do
    visit login_path
    fill_in 'session_email', with: login_user.email
    fill_in 'session_password', with: login_user.password
    click_button 'login-btn'
  end

  describe '記事の表示' do
    before do
      visit articles_path
    end

    context 'リクルーター' do
      let(:login_user) { user_recruiter }

      it '記事があるか確認' do
        expect(page).to have_selector '.card-title', text: article_a.title
      end

      it '記事詳細が表示されるか確認' do
        within "#article-#{article_a.id}" do
          click_on '記事を読む'
        end

        expect(page).to have_content '記事詳細'
      end
    end

    context 'シーカー' do
      let(:login_user) { user_seeker }

      it '記事があるか確認' do
        expect(page).to have_selector '.card-title', text: article_a.title
      end

      it '記事詳細が表示されるか確認' do
        within "#article-#{article_a.id}" do
          click_on '記事を読む'
        end

        expect(page).to have_content '記事詳細'
      end
    end
  end

  describe '記事作成' do
    let(:login_user) { user_recruiter }
    before do
      visit new_recruiter_article_path
      fill_in 'タイトル', with: 'エンジニア募集'
      fill_in 'コンテント', with: 'AWSができるバックエンドエンジニアを募集します。'
    end
    # TODO: 画像投稿バージョンを作る
    context '文章のみの投稿' do
      it '投稿した記事が表示される' do
        click_on '投稿する'
        expect(page).to have_selector '.card-title', text: 'エンジニア募集'
        expect(page).to have_selector '.card-text', text: 'AWSができるバックエンドエンジニアを募集します。'
      end
    end
  end

  describe '記事編集' do
    let(:login_user) { user_recruiter }
    before do
      visit article_path(article_a)
    end
    it '編集ボタンが表示されているか' do
      expect(find('.card-header')).to have_link '編集'
    end
    # TODO: 画像編集バージョンを作る

    context '文章のみの編集' do
      it '編集が反映される' do
        click_on '編集'
        expect(page).to have_selector 'h1', text: '記事編集'

        fill_in 'タイトル', with: '営業募集'
        fill_in 'コンテント', with: '営業を募集します'
        click_on '投稿する'

        expect(page).to have_selector '.card-title', text: '営業募集'
        expect(page).to have_selector '.card-text', text: '営業を募集します'
      end
    end
  end
end
