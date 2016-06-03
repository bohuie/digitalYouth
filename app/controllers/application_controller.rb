class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :notification_bar, :create_enricher
  protect_from_forgery with: :exception

  def notification_bar
    if user_signed_in?
    	enricher = StreamRails::Enrich.new 
      feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
      results = feed.get(limit: 10)['results']
      @bar_activities = enricher.enrich_aggregated_activities(results)

      @num_notifications_unseen = 0
      if @bar_activities != nil
        for act in @bar_activities
          if !act["activities"][0]["is_seen"]
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
    @enricher = StreamRails::Enrich.new 
  end
end
