class NotificationsController < ApplicationController

	before_action :authenticate_user!
	before_action :notification_owner, only: [:update, :delete, :trackable]
	respond_to :js, only: [:show, :update, :delete] # Formating for the AJAX request
	$limit = 5 # Changes the amount of notifications shown on the top bar

	def index # Get All notifications, mark seen
		@activities = get_notifications
	end

	def show # Get 6 notifications, mark seen
		@dropdown_activities = get_notifications.paginate(page: params[:page], per_page: 6)
	end

	def update # Mark the notification as read
		@notification.update(is_read: true)
	end

	def delete # Delete the notification
		@notification.destroy
	end

	def trackable # Mark read, redirect to trackable page
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

	def get_notifications
		rst = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id, owner_type: "User")
		rst.update_all(is_seen: true)
		return rst
	end
end
