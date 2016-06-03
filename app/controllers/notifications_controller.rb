class NotificationsController < ApplicationController

	before_action :authenticate_user!
	before_action :notification_owner

	def index
		#Mark seen on open
		enricher = StreamRails::Enrich.new 
		feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
		results = feed.get()['results']
		@activities = enricher.enrich_aggregated_activities(results)
	end

	def update
		#Mark Read
		byebug
		StreamRails.feed_manager.get_notification_feed(current_user.id).get(params[:id])
	end

	def delete
		#remove
	end

private
	def notification_owner

	end
end
