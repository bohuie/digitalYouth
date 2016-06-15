module NotificationsHelper
	# This method removes a notification that contains an empty object pointer
	# when displaying notifications. This is just here as a backup and is not
	# intended to be the method to delete an object's notification. That must 
	# be handled by the model/controller associated with that object. 
	def check_and_remove(activity)
		return false if activity.trackable
		activity.destroy # Else destroy and return true
		return true
	end

	# Styling for the notifications, sets class to read/unread and other options
	def get_read_options(activity)
		return "read", "visibility:hidden;" if activity["is_read"] 
		return "unread", ""
	end

	# Returns the number of notifications unseen for a user by usr_id
	def display_notif_unseen(usr_id)
      num = PublicActivity::Activity.where(is_seen: false, owner_id: usr_id, owner_type: "User").count
      return num if num > 0
      return "" # Else return blank string
    end
 
 	# Returns a font-size string for styling the notification counter
	def style_notif_count(num)
	  return "" if !num.is_a? Integer
	  return "font-size:5px;" if num > 99
	  return "font-size:10px;" if num > 9
	end
end

