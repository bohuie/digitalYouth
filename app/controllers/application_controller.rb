class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :notifications_setup
  protect_from_forgery with: :exception

  def notifications_setup
    if user_signed_in?
    	enricher = StreamRails::Enrich.new 
      feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
      results = feed.get()['results']
      @activities = enricher.enrich_aggregated_activities(results)
    end
  end

  def after_sign_in_path_for(resource)
  	current_user
  end
end
