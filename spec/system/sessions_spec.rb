require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user_recruiter) { FactoryBot.create(:recruiter, email: 'recruiter@test.com') }
  let(:user_seeker) { FactoryBot.create(:seeker, email: 'seeker@test.com') }

  before do
    visit login_path
    fill_in 'session_email', with: login_user.email
  end

  describe 'ログイン機能' do
    shared_examples_for 'ログイン確認' do
      context '正しいメールとパスワードを入力' do
        before do
          fill_in 'session_password', with: login_user.password
          click_button 'login-btn'
        end
        it 'ログインが完了して、ホームページに移動' do
          # homeに移動してることを確認
          expect(current_path).to eq home_path
          # flashのログインしましたを確認
          expect(page).to have_selector '.alert.alert-info', text: 'ログインしました。'
        end
      end

      context '間違ったパスワードを入力' do
        before do
          fill_in 'session_password', with: 'Wrong_password'
          click_button 'login-btn'
        end
        it 'login_pathのまま' do
          expect(current_path).to eq login_path
        end
      end
    end

    context 'Recruiter' do
      let(:login_user) { user_recruiter }
      it_behaves_like 'ログイン確認'
    end

    context 'Seeker' do
      let(:login_user) { user_seeker }
      it_behaves_like 'ログイン確認'
    end
  end

  # describe 'ログアウト機能' do
  # end
end
