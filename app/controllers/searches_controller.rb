class SearchesController < ApplicationController
	def index
		@query 	= params[:q].blank? ? "*" : params[:q]
		@filter = params[:f].nil? ? "Combined" : params[:f]
		@usr = current_user.id if user_signed_in?

		case @filter
			when "Combined"
				idxs=[User.searchkick_index.name,Project.searchkick_index.name,JobPosting.searchkick_index.name]
			when "Users"
				idxs=[User.searchkick_index.name]
			when "Projects"
				idxs=[Project.searchkick_index.name]
			when "JobPostings"
				idxs=[JobPosting.searchkick_index.name]
		end
		@results = User.search(@query, index_name: idxs, operator: "or", track: {user_id:@usr,search_type:@filter})
		@query = "" if @query == "*"
	end

	def navigate #Need to look into the security of this
		obj = params[:obj].constantize.find(params[:obj_id])
		Searchjoy::Search.find(params[:id]).convert(obj)
		redirect_to params[:path]
	end
end
