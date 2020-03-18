class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
  end

  def show
    notification = find_notification
    notification.update_attribute(:read, true)
    redirecto_to notification.path
  end

  def destroy
    notification = find_notification
    notification.destroy
    redirecto_to notifications_path
  end

  def read
    notification = find_notification
    notification.update(:read, true)
  end

  def clear_all
    current_user.notifications&.destroy_all
  end

  private

    def find_notification
      current_user.notifications.find(params[:id]) || redirect_to(root_path)
    end
end
