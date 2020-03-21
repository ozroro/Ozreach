class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
  end

  def show
    notification = find_notification
    notification.update_attribute(:read_flag, true)
    redirect_to notification.path
  end

  def destroy
    notification = find_notification
    notification.destroy
    redirect_to notifications_path
  end

  def read
    notification = find_notification
    notification.update(:read_flag, true)
  end

  def clear_all
    current_user.notifications&.destroy_all
  end

  private

    def find_notification
      current_user.notifications.find(params[:id]) || redirect_to(root_path)
    end
end
