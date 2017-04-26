class ResourceLinksController < ApplicationController

	before_action :authenticate_user!
	before_action :admin_only

	def update_all_announcements
		params["resource_link"].each do |index, value|
			if value[:id].blank? && !(!value[:destroy].blank? && value[:destroy] == "true")
				resource_link = ResourceLink.new(announcement_params(index))
				unless resource_link.save
					flash[:warning] = "Please fix the issues below."
					redirect_to user_path(current_user) and return
				end
			elsif !value[:id].blank?
				resource_link = ResourceLink.find(value[:id])
				if !value[:destroy].blank? && value[:destroy] == "true"
					resource_link.destroy
					flash[:success] ? flash[:success] += "  System Announcement successfully deleted." : flash[:success] = "System Announcement successfully deleted." 
				else
					unless resource_link.update_attributes(announcement_params(index))
						flash[:warning] = "Please fix the issues below."
						redirect_to user_path(current_user) and return
					end
				end
			end
		end
		flash[:success]  ? flash[:success] += "  System announcements successfully updated." : flash[:success] = "System announcements successfully updated." 
		redirect_to user_path(current_user)
	end

	def update_all_resource_links
		params["resource_link"].each do |index, value|
			if value[:id].blank? && !(!value[:destroy].blank? && value[:destroy] == "true")
				resource_link = ResourceLink.new(resource_link_params(index))
				unless resource_link.save
					flash[:warning] = "Please fix the issues below."
					redirect_to user_path(current_user) and return
				end
			elsif !value[:id].blank?
				resource_link = ResourceLink.find(value[:id])
				if !value[:destroy].blank? && value[:destroy] == "true"
					resource_link.destroy
					flash[:success] ? flash[:success] += "  Resource Link successfully deleted." : flash[:success] = "Resource Link successfully deleted." 
				else
					unless resource_link.update_attributes(resource_link_params(index))
						flash[:warning] = "Please fix the issues below."
						redirect_to user_path(current_user) and return
					end
				end
			end
		end
		flash[:success]  ? flash[:success] += "  Resource Links successfully updated." : flash[:success] = "Resource Links successfully updated." 
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
		params.require("resource_link").require(index).permit(:message, :announcement)
	end

	def resource_link_params(index)
		params.require("resource_link").require(index).permit(:message, :announcement, :link, :home_page_job_seeker, :home_page_job_provider, :bucket_job_provider, :bucket_job_seeker)
	end
end
