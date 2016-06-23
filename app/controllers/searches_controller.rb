class SearchesController < ApplicationController
	def index
		@query 	= params[:q].blank? ? "*" : params[:q]
		@type 	= params[:t].blank? ? "Combined" : params[:t]
		@filter = params[:f].nil? ? "" : params[:f]
		@value 	= params[:v].nil? ? "" : params[:v]
		@usr 	= current_user.id if user_signed_in?

		case @type # Modifies the indexes to search with, i.e. selects the model(s) to search from
		when "Combined"
			idxs=[User.searchkick_index.name,Project.searchkick_index.name,JobPosting.searchkick_index.name]
		when "Users"
			idxs=[User.searchkick_index.name]
		when "Projects"
			idxs=[Project.searchkick_index.name]
		when "JobPostings"
			idxs=[JobPosting.searchkick_index.name]
		else
			idxs=[]
		end

		where_clause = Hash.new
		case @filter # Modifies the where portion of the query
		when "Company"
			where_clause[:role]="employer"
			@provinces = User.select(:company_province).uniq.order(:company_province).where.not(company_province: nil)
			where_clause[:company_province]=@value.split(',') if !@value.empty?
		when "User"
			where_clause[:role]="employee"
		end

		@results = User.search @query, 
				 index_name: idxs, 
				 operator: "or", 
				 track: {user_id:@usr,search_type:@type},
				 where: where_clause
		
		@query = "" if @query == "*"
	end

	def navigate #Need to look into the security of this
		obj = params[:obj].constantize.find(params[:obj_id])
		Searchjoy::Search.find(params[:id]).convert(obj)
		redirect_to params[:path]
	end
end
