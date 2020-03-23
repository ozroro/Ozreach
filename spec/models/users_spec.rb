require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:recruiter)
  end

  describe 'バリデーション' do
    it 'emailが無効な形式の場合 => Invalid' do
      @user.email = 'test@invalid'
      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to be_present
    end

    it 'emailがユニークでない場合　=> Invalid' do
      common_email = 'common@test.com'
      # 共通のemailを持ったユーザーを作成しておく
      FactoryBot.create(:recruiter, email: common_email)
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

  describe 'コールバック' do
    context 'after_create' do
      it 'notificationsが追加される' do
        # FactroyBot.buildだとその時点で、after_createが実行されてしまうので（after_commitなら実行されない？）
        # User.newを使用する
        new_user = Recruiter::User.new(
          name: 'Alice',
          email: 'example@example.com',
          password: 'password',
          password_confirmation: 'password',
        )
        expect { new_user.save }.to change { new_user.notifications.size }.by(1)
      end
    end
  end
end
