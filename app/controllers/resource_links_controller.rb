class ResourceLinksController < ApplicationController

	before_action :authenticate_user!
	before_action :admin_only

	def update_all
		
		params["resource_link"].each do |index, value|
			resouce_link = ResourceLink.find(value[:id])
			unless resouce_link.update_attributes(announcement_params(index))
				flash.now[:warning] = "Please fix the issues below."
				redirect_to user_path(current_user) and return
			end
		end
		flash.now[:success] = "Password successfully updated."
		redirect_to user_path(current_user)
	end

	def create

	end

	private 

	def admin_only
		unless current_user.has_role? :admin
			flash[:warning] = "Sorry, we couldn't find that page."
			redirect_back_or
		end
	end

	def announcement_params(index)
		params.require("resource_link").require(index).permit(:message)
	end
end
