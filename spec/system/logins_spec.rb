require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  before do
    @user = FactoryBot.create(:recruiter)
  end

  describe 'ホームページの表示' do
    before do
      visit root_path
    end

    it '表示確認' do
      expect(page).to have_content 'OZReach'
    end
  end
end
