class NotificationsController < ApplicationController

	def index
		
	end

	def update
		result = StreamRails.feed_manager.notification_feed.get(:limit=>5, :mark_read=>[id])
	end
end
