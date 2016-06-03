class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :create_enricher, :notification_bar

  def notification_bar
    if user_signed_in?
      #Get feed for navbar notifications
      feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
      results = feed.get(limit: 10)['results']
      @bar_activities = @enricher.enrich_aggregated_activities(results)

      #Count the number of unseen notifications
      @num_notifications_unseen = 0
      if @bar_activities != nil
        for act in @bar_activities
          if !act["is_seen"]
            @num_notifications_unseen = @num_notifications_unseen + 1
          end
        end
      end
    end
  end

  def after_sign_in_path_for(resource)
  	current_user
  end

  def create_enricher
    #Create activity enricher for all controllers
    @enricher = StreamRails::Enrich.new 
  end
end
