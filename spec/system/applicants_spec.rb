require 'rails_helper'

RSpec.describe 'Applicants', type: :system do
  let(:user_recruiter) { FactoryBot.create(:recruiter, email: 'recruiter@test.com') }
  let(:user_seeker) { FactoryBot.create(:seeker, email: 'seeker@test.com', name: 'テストシーカー') }
  let!(:applied_article) { FactoryBot.create(:article, title: 'Railsプログラマー募集', user: user_recruiter) }
  let!(:applicant) { FactoryBot.create(:seeker_applicant, user: user_seeker, recruiter_article: applied_article) }
  let(:unapplied_article) { FactoryBot.create(:article, title: 'バックエンドエンジニア募集', user: user_recruiter) }

  before do
    visit login_path
    # login_userは後でletで書き換える
    fill_in 'session_email', with: login_user.email
    fill_in 'session_password', with: login_user.password
    click_button 'login-btn'
  end

  describe '応募一覧の確認' do
    context 'Seeker 応募履歴' do
      let(:login_user) { user_seeker }
      before { visit seeker_applicants_path }
      it 'ページタイトルの表示' do
        expect(page).to have_content '応募履歴'
      end
      it '応募済みの募集記事のタイトルが表示される' do
        expect(page).to have_content 'Railsプログラマー募集'
      end
    end

    context 'Recruiter 応募者一覧' do
      let(:login_user) { user_recruiter }
      before { visit recruiter_applicants_path }
      it 'ページタイトルの表示' do
        expect(page).to have_content '応募者一覧'
      end
      it '応募したユーザーが表示される' do
        expect(page).to have_content 'テストシーカー'
      end
    end
  end

  describe '応募ボタンの確認' do
    let(:login_user) { user_seeker }
    context '応募済みの記事' do
      before { visit article_path(applied_article) }
      it '応募ボタンが無い' do
        expect(page).not_to have_css '.applicant_button'
      end
    end
    context '応募していない記事' do
      before do
        visit article_path(unapplied_article)
      end
      it '応募ボタンがある' do
        expect(page).to have_css '.applicant_button'
      end
    end
  end

  describe '応募作成' do
    let(:login_user) { user_seeker }

    before do
      visit article_path(unapplied_article)
      click_on 'article-button'
      click_on 'modal-button'
    end

    context 'Seeker' do
      it '応募履歴ページに応募がある' do
        visit seeker_applicants_path
        expect(page).to have_content 'バックエンドエンジニア募集'
      end
    end
  end

  describe '応募削除' do
    context 'Seeker 応募削除' do
      let(:login_user) { user_seeker }
      before do
        visit seeker_applicants_path
        click_on "applicant-#{applicant.id}"
        page.driver.browser.switch_to.alert.accept
      end
      it '応募済みの募集記事のタイトルが削除' do
        visit seeker_applicants_path
        expect(page).not_to have_content 'Railsプログラマー募集'
      end
    end
  end
end
