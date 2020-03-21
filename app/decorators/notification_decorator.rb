class NotificationDecorator < Draper::Decorator
  delegate_all
  ALERM_ICON_CLASS = {
    my_profile: { icon: 'fa-id-card', bg: 'bg-secondary' },
    article: { icon: 'fa-newspaper', bg: 'bg-success' },
    recrutier_applicants: { icon: 'fa-file-alt', bg: 'bg-danger' },
    recruiter_applicant: { icon: 'fa-vote-yea', bg: 'bg-info' },
    seeker_applicants: { icon: 'fa-file-alt', bg: 'bg-info' }
  }.with_indifferent_access

  def icon
    ALERM_ICON_CLASS[object.link_type][:icon]
  end

  def bg
    ALERM_ICON_CLASS[object.link_type][:bg]
  end

  def time_ago_in_words
    h.time_ago_in_words(object.created_at) + '前'
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
