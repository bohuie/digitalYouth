class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :notification_bar

  def notification_bar
    if user_signed_in?
      #Count the number of unseen notifications
      results = StreamRails.feed_manager.get_notification_feed(current_user.id).get()['results']
      num = 0
      if results != nil
        results.each {|r| num = num + 1 if !r["is_seen"]}
      end
      @num_notifications_unseen = num
      @notif_link_string = make_notif_link_string(results.size)
    end
  end

  def after_sign_in_path_for(resource)
  	current_user
  end

  def make_notif_link_string(count)
    link_string = "Show all notifications"
    link_string += " - (You have #{count} notification" if count > 0
    link_string += "s" if count > 1
    link_string += ")" if count > 0
    return link_string
  end
end


