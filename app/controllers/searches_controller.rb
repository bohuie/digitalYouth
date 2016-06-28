class SearchesController < ApplicationController

	respond_to :js, only: :index # Formating for the AJAX requests
	respond_to :html

	def index
		# Basic Filtering parameters
		@query 	= params[:q].blank? ? "*" : params[:q]
		@type 	= params[:t].blank? ? "All" : params[:t]
		@filters = params[:f].nil? ? "" : params[:f]
		@usr 	= current_user.id if user_signed_in?

		#Values for where clause
		@l 	= params[:l].nil?  ? "" : params[:l]
		@i 	= params[:i].nil?  ? "" : params[:i]
		@c 	= params[:c].nil?  ? "" : params[:c]
		@cc = params[:cc].nil? ? "" : params[:cc]
		@pc = params[:pc].nil? ? "" : params[:pc]
		@cz = params[:cz].nil? ? "" : params[:cz]
		@e 	= params[:e].nil?  ? "" : params[:e]
		@r 	= params[:r].nil?  ? "" : params[:r]
		@s 	= params[:s].nil?  ? "" : params[:s]
		@jf = params[:jf].nil? ? "" : params[:jf]
		@el = params[:el].nil? ? "" : params[:el]
		@dp = params[:dp].nil? ? "" : params[:dp]
		@h 	= params[:h].nil?  ? "" : params[:h]

		#Hashes for filtering
		@toggles = Hash.new()
		where_clause = Hash.new()

		case @type # Modifies the indexes to search with, i.e. selects the model(s) to search from, also sets up extra data
		when "All"
			idxs=[User.searchkick_index.name,Project.searchkick_index.name,JobPosting.searchkick_index.name]
			@toggles = {location: true, industry: true}
			@locations = []
			@industries = nil
		when "People"
			idxs=[User.searchkick_index.name]
			where_clause[:role]="employee"
			@toggles = {relationship: true, location: true, current_company: true, industry: true, past_company: true, education: true, skills:true}
			@locations = []
			@current_companies = nil
			@past_companies = nil
			@education = nil
			@skills = nil
		when "Companies"
			idxs=[User.searchkick_index.name]
			where_clause[:role]="employer"
			@toggles = {relationship: true, location:true, hiring: true, industry: true, company_size: true}
			@locations = User.where.not(company_province: nil).uniq.order(:company_province).pluck(:company_province)
			@company_sizes = ["1-10","11-50","51-200","201-500","501-1000","1001-5000","5001-10000","10000+"]
			@industries = nil
		when "Projects"
			idxs=[Project.searchkick_index.name]
			@toggles = {skills: true, industry: true}
			@skills = nil
			@industry = nil
		when "JobPostings"
			idxs=[JobPosting.searchkick_index.name]
			@toggles = {location: true, company: true, date_posted: true, job_function: true, industry: true, experience_level: true, skills: true}
			@locations = []
			@companies = nil
			@dates_posted = ["1", "2-7", "8-14","15-30","30+"]
			@job_functions = nil
			@industries = nil
			@experience_levels = ["Entry Level", "Associate", "Not Applicable", "Internship", "Mid-Senior Level", "Director", "Executive"]
			@skills = nil
		else
			idxs=[]
		end

		if !@filters.blank?
			filter = @filters.split(',') if !@filters.empty?
			filter.each do |f|
				case f # Modifies the where portion of the query
				when "location"
					where_clause[:company_province]=@l.split(',') if !@l.empty?
				when "industry"
					where_clause[:industry]=@i.split(',') if !@i.empty?
				when "company"
					where_clause[:company]=@c.split(',') if !@c.empty?
				when "current_company"
					where_clause[:current_company]=@cc.split(',') if !@cc.empty?
				when "past_company"
					where_clause[:past_company]=@pc.split(',') if !@pc.empty?
				when "company_size"
					where_clause[:company_size]=@cz.split(',') if !@cz.empty?
				when "education"
					where_clause[:education]=@e.split(',') if !@e.empty?
				when "relationship"
					where_clause[:relationship]=@r.split(',') if !@r.empty?
				when "skills"
					where_clause[:skills]=@s.split(',') if !@s.empty?
				when "job_function"
					where_clause[:job_function]=@jf.split(',') if !@jf.empty?
				when "experience_level"
					where_clause[:experience_level]=@el.split(',') if !@el.empty?
				when "date_posted"
					where_clause[:created_on]=@dp.split(',') if !@dp.empty?
				where "hiring"
					where_clause[:hiring]=@h.split(',') if !@h.empty?
				end
			end
		end

		# Need to fix N+1 query problem here with rolify
		@results = User.search @query, 
				 index_name: idxs,
				 operator: "or", 
				 track: {user_id:@usr,search_type:@type},
				 where: where_clause,
				 page: params[:page], per_page: 30

		@query = "" if @query == "*"
	end

	def navigate
		obj = params[:obj].constantize.find(params[:obj_id])
		Searchjoy::Search.find(params[:id]).convert(obj)
		redirect_to params[:path]
	end

end
