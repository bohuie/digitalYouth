class Reference < ActiveRecord::Base
	belongs_to :user

	include StreamRails::Activity
	as_activity

	def activity_notify
		[StreamRails.feed_manager.get_notification_feed(self.user_id)]
	end

	def activity_author
		self.user
	end

	def activity_extra_data
    	{'read': false, 'seen': false}
  	end

	def activity_object
		self
	end
end
