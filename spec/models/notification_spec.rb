# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  description :string(255)
#  link_option :string(255)
#  link_type   :string(255)
#  read_flag   :boolean          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'コールバック' do
    context 'after_commit :destroy_oldest_notification, if: :reached_limit?' do
      context 'MAX_SIZEに達していない' do
        before do
          @user = FactoryBot.create(:recruiter)
          @size = Notification::MAX_SIZE - @user.notifications.size - 1 # 境界条件
          @size.times { @user.notifications.create(FactoryBot.attributes_for(:notification)) }
        end
        it '1追加される' do
          new_attribute = FactoryBot.attributes_for(:notification)
          expect { @user.notifications.create(new_attribute) }.to change { @user.notifications.size }.by(1)
        end

        it '一番古いものが削除されない' do
          oldest_notification = @user.notifications.order(:created_at).first
          @user.notifications.create(FactoryBot.attributes_for(:notification))
          expect(@user.notifications.reload).to include(oldest_notification)
        end
      end

      context 'MAX_SIZEに達している' do
        before do
          @user = FactoryBot.create(:recruiter)
          @size = Notification::MAX_SIZE - @user.notifications.size
          @size.times { @user.notifications.create(FactoryBot.attributes_for(:notification)) }
        end
        it '一番古いデータが削除' do
          oldest_notification = @user.notifications.order(:created_at).first
          @user.notifications.create(FactoryBot.attributes_for(:notification))
          expect(@user.notifications.reload).not_to include(oldest_notification)
        end

        it '総数がをMAX_SIZEより増えない' do
          expect(@user.notifications.size).to eq Notification::MAX_SIZE

          new_attribute = FactoryBot.attributes_for(:notification)
          expect { @user.notifications.create(new_attribute) }.to change { @user.notifications.size }.by(0)
        end
      end
    end
  end
end
