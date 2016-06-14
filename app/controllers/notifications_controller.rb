class NotificationsController < ApplicationController

	before_action :authenticate_user!
	before_action :notification_owner, only: [:update, :delete, :trackable]
	respond_to :js, only: [:show, :update, :delete] # Formating for the AJAX request

	def index # Get All notifications, mark seen
		@activities = get_notifications
	end

	def show # Get 6 notifications first, then get one and offset the page
		params[:page] = 1 if params[:page].nil?

		if Integer(params[:page]) > 1
			params[:page] = String((Integer(params[:page]) + 6))
			@dropdown_activities = get_notifications.paginate(page: params[:page], per_page: 1)
		else
			@dropdown_activities = get_notifications.paginate(page: params[:page], per_page: 6)
		end
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
			redirect_to user_path(current_user) , flash: {danger: "You do not own that notification."}
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
