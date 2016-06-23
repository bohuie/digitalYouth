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

  # Redirect to stored location (or specified)
  # Usage:
  # redirect_back_or // This redirects to the last visited page.
  #                   // If there is no page and no specified path, it will go to root_path
  # redirect_back_or current_user_path // This redirects to the current_user page
  def redirect_back_or (specified =nil)
    if specified.nil? && session[:forwarding_url].nil?
      redirect_to root_path
    elsif specified.nil?
       redirect_to(session[:forwarding_url])
    else
      redirect_to (specified)
    end
    session.delete(:forwarding_url)
  end

  # Stores the last URL visited.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end

