module NotificationsHelper
  ALERM_CENTER_SIZE = 4

  def notification_badge_counter
    count = current_user.notifications.unread.size
    if count == 0
      nil
    elsif count > ALERM_CENTER_SIZE
      "#{ALERM_CENTER_SIZE}+"
    else
      count.to_s
    end
  end

  def recent_notifications
    current_user.notifications.unread.limit(ALERM_CENTER_SIZE).decorate
  end
end
