class NotificationsController < ApplicationController

	before_action :authenticate_user!
	before_action :notification_owner, only: [:update, :delete, :trackable]
	respond_to :js, only: [:show, :update, :delete] # Formating for the AJAX request
	$limit = 5

	def index # Get All notifications, mark seen
		@activities = get_notifications
	end

	def show # Get 5 notifications, mark seen 
		@dropdown_activities = get_notifications[0 .. ($limit-1)]
	end

	def update # Mark the notification as read and refetch the notifications
		@notification.update(is_read: true)
		@dropdown_activities = get_notifications_limited
	end

	def delete # Delete the notification and refetch the notifications
		@notification.destroy
		@dropdown_activities = get_notifications_limited
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
	# Should implement a scroll bar autoloading thing. Need to figure out if there is a gem to support it.
	def get_notifications_limited
		return PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id, owner_type: "User").limit($limit)
	end

	def get_notifications
		rst = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id, owner_type: "User")
		rst.update_all(is_seen: true)
		return rst
	end
end
