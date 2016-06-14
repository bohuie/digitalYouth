module NotificationsHelper
	# This method removes a notification that contains an empty object pointer
	# when displaying notifications. This is just here as a backup and is not
	# intended to be the method to delete an object's notification. That must 
	# be handled by the model/controller associated with that object. 
	def check_and_remove(activity)
		if !activity.trackable
			activity.destroy
			return true
		else
			return false
		end
	end

	# Styling for the notifications, sets class to read/unread and other options
	def get_read_options(activity)
		if activity["is_read"]
			return "read", "visibility:hidden;"
		else 
			return "unread", ""
		end
	end

	# Returns the number of notifications unseen for a user by usr_id
	def display_notif_unseen(usr_id)
      num = PublicActivity::Activity.where(is_seen: false, owner_id: usr_id, owner_type: "User").count
      if num > 0
        return num
      else
        return ""
      end
    end
 
 	# Returns a font-size string for styling the notification counter
	def style_notif_count(num)
	  style_str = ""
	  if num.is_a? Integer
	    if num > 99
	      style_str = "font-size:5px;"
	    elsif num > 9
	      style_str = "font-size:10px;"
	    end
	  end
	  return style_str
	end

end

