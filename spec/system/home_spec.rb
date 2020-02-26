require 'rails_helper'

RSpec.describe 'Home', type: :system do
  describe 'ホームページの表示' do
    before do
      visit root_path
    end

    it '表示確認' do
      expect(page).to have_content 'OZReach'
    end
  end
  # describe 'ログイン後のホーム画面' do
  #   context 'Recruiter' do

  #   end
  # end
end
