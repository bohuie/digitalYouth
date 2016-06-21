class ApplicationController < ActionController::Base
  include NotificationsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :notification_bar
  after_action :store_location

  def notification_bar
    if user_signed_in?
      @notif_unseen = display_notif_unseen(current_user.id)
      @notif_count_style = style_notif_count(@notif_unseen)
    end
  end

  def after_sign_in_path_for(resource)
  	current_user
  end

  # Redirect to stored location (or default)
  def redirect_back_or (default =nil)
    if default.nil?
       redirect_to(session[:forwarding_url])
    else
      redirect_to (default)
    end
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end

