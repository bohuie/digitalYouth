module NotificationsHelper
	# This method removes a notification that contains an empty object pointer
	# when displaying notifications. This is just here as a backup and is not
	# intened to be the method to delete an object's notification. That must 
	# be handled by the model/controller associated with that object. 
	def check_and_remove(activity)
		if !activity.trackable
			activity.destroy
			return true
		else
			return false
		end
	end

	# This is for styling the notifications
	def get_read_options(activity)
		if activity["is_read"]
			return "read", "visibility:hidden;"
		else 
			return "unread", ""
		end
	end
end
