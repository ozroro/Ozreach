module ApplicationHelper
  include Pagy::Frontend

  def bootstrap_class_for(flash_type)
    flash_to_bootstrap_class = {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }.with_indifferent_access
    flash_to_bootstrap_class[flash_type] || flash_type.to_s
  end
end
