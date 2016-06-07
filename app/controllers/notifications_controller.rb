class NotificationsController < ApplicationController

	before_action :authenticate_user!
	before_action :notification_owner, only: [:update, :delete]

	def index
		#Get notifications, mark seen
		feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
		results = feed.get(mark_seen: true)['results']
		@activities = @enricher.enrich_aggregated_activities(results)
	end

	def show 
		#Get notifications, mark seen (should limit this to 5 or 10 or so)
		feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
		results = feed.get(limit: 10, mark_seen: true)['results']
		@dropdown_activities = @enricher.enrich_aggregated_activities(results)

		# Formating for the AJAX request
		respond_to do |format|
        	format.js
   		end
	end

	def update # For some reason it doesn't update on the first click
		#Get notifications, mark the notification as read
		feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
		results = feed.get(limit: 10, mark_read:[params[:id]])['results']
		@dropdown_activities = @enricher.enrich_aggregated_activities(results)

		# Formating for the AJAX request
		respond_to do |format|
        	format.js
   		end
	end

	def delete
		#Get notifications, Remove the notification
		feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
		feed.remove_activity(params[:id])
		results = feed.get()['results']
		@dropdown_activities = @enricher.enrich_aggregated_activities(results)

		# Formating for the AJAX request
		respond_to do |format|
        	format.js
   		end
	end

private
	def notification_owner
		# Check to see if the user owns the notification
	end
end
