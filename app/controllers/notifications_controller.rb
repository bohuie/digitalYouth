class NotificationsController < ApplicationController

	def index
		#Mark seen on open
		enricher = StreamRails::Enrich.new 
		feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
		results = feed.get()['results']
		@activities = enricher.enrich_aggregated_activities(results)
	end

	def update
		#Mark Read
		StreamRails.feed_manager.notification_feed.get( mark_read: params[:id])
	end

	def delete
		#remove
	end
end
