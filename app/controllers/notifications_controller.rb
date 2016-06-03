class NotificationsController < ApplicationController

	before_action :authenticate_user!, :notification_owner

	def index
		#Get notifications, mark seen
		feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
		results = feed.get(mark_seen: true)['results'] #This doesn't actually mark_seen right now
		@activities = @enricher.enrich_aggregated_activities(results)
	end

	def show 
		#Get notifications, mark seen (should limit this to 5 or 10 or so)
		feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
		results = feed.get(mark_seen: true)['results'] #This doesn't actually mark_seen right now
		@dropdown_activities = @enricher.enrich_aggregated_activities(results)

		# Formating for the AJAX request
		respond_to do |format|
        	format.js
   		end
	end

	def update
		#Get notifications, mark the notification as read
		feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
		results = feed.get(mark_read: true)['results'] #This doesn't actually mark_read right now
		@dropdown_activities = @enricher.enrich_aggregated_activities(results)

		# Formating for the AJAX request
		respond_to do |format|
        	format.js
   		end
	end

	def delete
		#Get notifications, Remove the notification
		#Dont know what to do yet

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
