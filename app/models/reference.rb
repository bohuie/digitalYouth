class Reference < ActiveRecord::Base
	belongs_to :user

	include StreamRails::Activity
	as_activity

	def activity_notify
		[StreamRails.feed_manager.get_notification_feed(self.user_id)]
	end

	def activity_actor
    	self.user
  	end

	def activity_object
		self
	end

end
