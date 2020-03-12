require 'rails_helper'

RSpec.describe 'Applicants', type: :system do
  let(:user_recruiter) { FactoryBot.create(:recruiter, email: 'recruiter@test.com') }
  let(:user_seeker) { FactoryBot.create(:seeker, email: 'seeker@test.com', name: 'テストシーカー') }
  let!(:article_a) { FactoryBot.create(:article, title: 'Railsプログラマー募集', user: user_recruiter) }
  let!(:applicant_a) { FactoryBot.create(:seeker_applicant, user: user_seeker, recruiter_article: article_a) }
  before do
    visit login_path
    fill_in 'session_email', with: login_user.email
    fill_in 'session_password', with: login_user.password
    click_button 'login-btn'
  end

  #
  # 応募一覧の確認
  # 1シーカーで確認
  # 2リクルーターで確認
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

  # A. 応募ボタンの確認
  # A-1 シーカーログイン
  # A-2 応募済み記事の表示　
  # A-3 応募ボタンが無いことを確認
  # A-4 応募してない記事の表示
  # A-5 応募ボタンがあることを確認

  # B. 応募作成
  # B-1 シーカーログイン
  # B-2 応募してない記事ページを表示
  # B-3 応募ボタンを押す
  # B-4 応募確認モーダルの応募するボタンを押す
  # B-5 応募一覧ページを表示
  # B-6 新しい応募があることを確認

  # C. 応募削除
  # C-1 シーカーログイン
  # C-2 応募履歴ページを表示する
  # C-3 取り消しボタンを押す
  # C-4 確認のOKを押す
  # C-5 応募履歴ページを表示する
  # C-6 応募が消されたことを確認
end
