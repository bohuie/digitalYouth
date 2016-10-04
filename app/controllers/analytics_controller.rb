class AnalyticsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_admin

	def index
		@visits = Visit.all
	end

	def show
		@visit = Visit.find(params[:id])
		@events = @visit.ahoy_events
		@view_ends = @events.where(name:"$view_end").pluck(:properties)
		@page_times = Hash.new
		@view_ends.each do |e|
			if @page_times[e["page"]].nil? 
				@page_times[e["page"]] = e["time"]
			else
				e["time"] = 0 if e["time"].nil?
				@page_times[e["page"]] += e["time"]
			end
		end
	end

private
	def check_admin # Checks current user is an admin
		redirect_back_or root_path if !current_user.has_role? :admin
	end
end