class SearchesController < ApplicationController
	def index
		@query 	= params[:q].blank? ? "*" : params[:q]
		@filter = params[:f].nil? ? "combined" : params[:f]
		@usr = current_user.id if user_signed_in?

		if @filter == "combined"
			@results = User.search(@query, index_name: [User.searchkick_index.name,Project.searchkick_index.name,JobPosting.searchkick_index.name], operator: "or", track:true)
		else
			case @filter
			when "users"
				@results = User.search(@query, track:true)
			when "projects"
				@results = Project.search(@query, track:true)
			when "postings"
				@results = JobPosting.search(@query, track:true)
			end
		end
		Searchjoy::Search.create(search_type:@filter,query:@query,results_count:@results.size,user_id:@usr) if !@results.nil?
		@query = "" if @query == "*"
	end

	def navigate #Need to look into the security of this
		obj = params[:obj].constantize.find(params[:obj_id])
		Searchjoy::Search.find(params[:id]).convert(obj)
		redirect_to params[:path]
	end
end
