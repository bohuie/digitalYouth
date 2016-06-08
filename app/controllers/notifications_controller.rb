class NotificationsController < ApplicationController

	before_action :authenticate_user!
	before_action :notification_owner, only: [:update, :delete, :trackable]

	def index
		#Get notifications, mark seen
		@activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id, owner_type: "User")
		@activities.update_all(is_seen: true)
	end

	def show 
		#Get notifications, mark seen 
		
		@dropdown_activities = get_notifications(nil,nil)
		@dropdown_activities.update_all(is_seen: true)
		@notif_unseen = display_notif_unseen

		# Formating for the AJAX request
		respond_to do |format|
        	format.js
   		end
	end

	def update
		# Mark the notification as read and refetch the notifications
		@notification.update(is_read: true)
		@dropdown_activities = get_notifications(nil,nil)

		# Formating for the AJAX request
		respond_to do |format|
        	format.js
   		end
	end

	def delete
		# Delete the notification and refetch the notifications
		@notification.destroy
		@dropdown_activities = get_notifications(nil,nil)

		# Formating for the AJAX request
		respond_to do |format|
        	format.js
   		end
	end

	def trackable
		@notification.update(is_read: true)
		redirect_to polymorphic_path(@notification.trackable)
	end

private
	def notification_owner
		@notification = PublicActivity::Activity.find(params[:id])
		if @notification.owner_type != "User" || @notification.owner_id != current_user.id
			redirect_to root_path , flash: {danger: "You do not own that notification."}
		else
			return @notification
		end
	end

	# TODO:
	# Display scrollbar at all times
	def get_notifications(limit, offset)
		lim = 5 if limit == nil
		off = 0 if offset == nil
		return PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id, owner_type: "User").limit(lim).offset(off)
	end
end
