class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :notification_bar

  def notification_bar
    if user_signed_in?
      @notif_unseen = display_notif_unseen
    end
  end

  def after_sign_in_path_for(resource)
  	current_user
  end

  def display_notif_unseen
      num = PublicActivity::Activity.where(is_seen: false, owner_id: current_user.id, owner_type: "User").count
      if num > 0
        return num
      else
        return ""
      end 
  end
end


