class ApplicationController < ActionController::Base
  include NotificationsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :notification_bar

  def notification_bar
    if user_signed_in?
      @notif_unseen = display_notif_unseen(current_user.id)
      @notif_count_style = style_notif_count(@notif_unseen)
    end
  end

  def after_sign_in_path_for(resource)
  	current_user
  end
end

