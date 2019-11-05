require 'rails_helper'


# 練習のためにずらずら書いたけど、この程度の単純なバリデーションならそもそも書く必要ないかも
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:recruiter)
  end

  describe 'バリデーション' do

    it '有効なname,email,passwordが設定されている場合 => Valid' do
      expect(@user).to be_valid
    end

    it 'nameが空の場合 => Invalid' do
      @user.name = ''
      expect(@user).to_not be_valid
      expect(@user.errors[:name]).to be_present
    end

    it 'emailが空の場合　=> Invalid' do
      @user.email = ''
      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to be_present
      
    end

    it 'emailの長さが256以上の場合 => Invalid' do
      @user.email = 'test' * 100 + '@test.com'
      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to be_present
    end

    it 'emailが無効な形式の場合 => Invalid' do
      @user.email = 'test@invalid'
      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to be_present
    end
    
    it 'emailがユニークでない場合　=> Invalid' do
      common_email = "common@test.com"
      common_email_user = FactoryBot.create(:recruiter, email: common_email)  
      @user.email = common_email
      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to be_present
    end

    it 'passwordが空の場合 => Invalid' do
      # @user.password = '' としてもパスワードが更新されないのでバリデーションが通ってしまう
      # 最初から空のパスワードのユーザーを作る
      @blankpass_user = FactoryBot.build(:recruiter, password: '')
      expect(@blankpass_user).to_not be_valid
      expect(@blankpass_user.errors[:password]).to be_present
    end

    it 'passwordが６字未満の場合 => Invalid' do
      @user.password = 'test'
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to be_present
    end

  end

  describe 'recruiter? seeker? メソッド' do

    before do
      @recruiter = FactoryBot.create(:recruiter)
      @seeker = FactoryBot.create(:seeker)
    end


    context 'Recruiterの場合' do
      it 'recruiter?でtrueを返す' do
        expect(@recruiter.recruiter?).to be true
      end
      it 'seeker?でfalseを返す' do
        expect(@recruiter.seeker?).to be false
      end
    end

    context 'Seekerの場合' do

      it 'recruiter?でfalseを返す' do
        expect(@seeker.recruiter?).to be false
      end

      it 'seeker?でtrueを返す' do
        expect(@seeker.seeker?).to be true
      end

    end

  end


end
