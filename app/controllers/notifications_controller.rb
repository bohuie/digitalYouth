class NotificationsController < ApplicationController

	before_action :authenticate_user!
	before_action :notification_owner, only: [:update, :delete, :trackable]

	respond_to :js # Formating for the AJAX requests
	respond_to :html, only: :index

	def index # Get all notifications, paginates to 20
		@notifications = get_notifications.paginate(page: params[:page], per_page: 20)
		@notifications_count = @notifications.count
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
	end

	def show # Get 5 notifications first, then get one and offset the page
		params[:page] = 1 if params[:page].nil?
		per_pg = 6
		if Integer(params[:page]) > 1
			params[:page] = Integer(params[:page]) + 5
			per_pg = 1
		end
		@dropdown_notifications = get_notifications.paginate(page: params[:page], per_page: per_pg)
		@dropdown_notifications_count = @dropdown_notifications.count
	end

	def update # Mark the notification as read
		@notification.update(is_read: true)
	end

	def delete # Delete the notification
		@notification_id = @notification.id
		@notification.delete
		@notifications_count = PublicActivity::Activity.where(owner_id: current_user.id, owner_type: "User").count
	end

	def update_all # Mark all notifications as read
		@notifications = update_notifications
	end

	def delete_all # Delete all notifications
		PublicActivity::Activity.where(owner_id: current_user.id, owner_type: "User").delete_all
	end

	def trackable # Mark read, redirect to trackable page
		@notification.update(is_read: true)
		
		if @notification.trackable_type == "ReferenceRedirection"
			redirect_to controller: 'references', action: 'new', id: @notification.parameters[:url]
		elsif @notification.trackable_type == "Reference"
			session[:home_tab] = "references"
			redirect_to controller: 'users', action: 'show', id: @notification.owner_id
		else
			redirect_to polymorphic_path(@notification.trackable)
		end
	end

private
	def notification_owner # Verifies the user owns the notification
		@notification = PublicActivity::Activity.find(params[:id])
		if @notification.owner_type != "User" || @notification.owner_id != current_user.id
			redirect_to user_path(current_user) , flash: {danger: "You do not own that notification."}
		else
			return @notification
		end
	end

	def get_notifications # Retrieves a users notifications and marks as seen
		rst = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id, owner_type: "User").includes(:trackable)
		rst.update_all(is_seen: true) if @notif_unseen.is_a? Integer # if all notifications are seen, this @notif_unseen "", else they are all updated
		return rst
	end

	def update_notifications # Retrieves a users notifications and marks as read
		rst = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id, owner_type: "User").includes(:trackable)
		rst.update_all(is_read: true)
		return rst
	end
end
