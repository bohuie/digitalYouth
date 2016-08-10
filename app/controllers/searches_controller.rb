class SearchesController < ApplicationController

	respond_to :js, only: :index # Formating for the AJAX requests
	respond_to :html

	def index # index page displays all search data

		# Basic Filtering parameters
		@query 	= params[:q].blank? ? "*" : params[:q]
		@type 	= params[:t].blank? ? "All" : params[:t]
		@filters = params[:f].nil? ? "" : params[:f]
		@usr 	= current_user.id if user_signed_in?

		#Values for where clause
		@l 	= params[:l].nil?  ? "" : params[:l]  #location
		@i 	= params[:i].nil?  ? "" : params[:i]  #industry
		@c 	= params[:c].nil?  ? "" : params[:c]  #company
		@cc = params[:cc].nil? ? "" : params[:cc] #current_company
		@pc = params[:pc].nil? ? "" : params[:pc] #past_company
		@r 	= params[:r].nil?  ? "" : params[:r]  #relationship
		@s 	= params[:s].nil?  ? "" : params[:s]  #skills
		@jt = params[:jt].nil? ? "" : params[:jt] #job_type
		@dp = params[:dp].nil? ? "" : params[:dp] #date_posted
		@h 	= params[:h].nil?  ? "" : params[:h]  #hiring

		#Hashes for filtering
		@toggles = Hash.new()
		where_clause = Hash.new()

		case @type # Modifies the indexes to search with, i.e. selects the model(s) to search from, sets up extra data, and filters
		when "All" # Searches all models, has no filters
			idxs=[User.searchkick_index.name,Project.searchkick_index.name,JobPosting.searchkick_index.name]
			@toggles = {}

		when "People" # Searches User model, just employees, filters relationship, location, current + past company, and skills
			idxs=[User.searchkick_index.name]
			where_clause[:role]="employee"
			@toggles = {r: @r, l: @l, cc: @cc, pc: @pc, s:@s}
			@locations = [] # To be implemented
			@relationships = ["1st","2nd", "Group Members", "3rd + Everyone"]
			@current_companies = [] # To be implemented
			@past_companies = [] # To be implemented

			# Postgres query finds the most popular skill names (restricting length)
			@pgrec = ActiveRecord::Base.connection.execute("
					SELECT skills.name 
					FROM user_skills, skills 
					WHERE user_skills.skill_id = skills.id 
					  AND length(skills.name) < 50
					GROUP BY skills.name 
					ORDER BY COUNT(user_skills.id) DESC 
					LIMIT 5")
			@skills = Array.new
			@pgrec.each do |s| @skills.push(s["name"]) end

		when "Companies" # Searches User model, just employers, filters location and industry
			idxs=[User.searchkick_index.name]
			where_clause[:role]="employer"
			@toggles = {l: @l, i: @i}

			@locations = Array.new
			locs = User.where.not(company_province: nil).group(:company_province,:company_city).order("COUNT(id)").limit(5).pluck(:company_city, :company_province)
			locs.each do |l| 
				@locations.push(l[0]+', '+l[1])
			end
			@relationships = ["1st","2nd", "Group Members", "3rd + Everyone"]
			@industries = JobCategory.all.pluck(:name)

		when "Projects" # Searches Project model, filters date-posted and skills
			idxs=[Project.searchkick_index.name]
			@toggles = { dp: @dp, s:@s}

			# Postgres query finds the most popular skill names (restricting length)
			@pgrec = ActiveRecord::Base.connection.execute("
					SELECT skills.name 
					FROM project_skills, skills 
					WHERE project_skills.skill_id = skills.id 
					  AND length(skills.name) < 50
					GROUP BY skills.name 
					ORDER BY COUNT(project_skills.id) DESC 
					LIMIT 5")
			@skills = Array.new
			@pgrec.each do |s| @skills.push(s["name"]) end

			@dates_posted = ["1", "2-7", "8-14","15-30","30+"]

		when "JobPostings" # Searches JobPosting, filters location, company, dateposted, industry, job type, skills.
			idxs=[JobPosting.searchkick_index.name]
			@toggles = {l: @l, c: @c, dp: @dp, i: @i, jt: @jt, s:@s}
			
			# Postgres query finds the most popular company names joining between the two places the name can exist
			@pgrec = ActiveRecord::Base.connection.execute("
							SELECT company_name FROM(
							(SELECT users.company_name, COUNT(job_postings.id) AS cnt
							FROM job_postings, users 
							WHERE job_postings.user_id = users.id 
							AND (job_postings.user_id IS NOT NULL) 
							GROUP BY users.company_name)
							UNION
							(SELECT job_postings.company_name, COUNT(job_postings.id) AS cnt
							FROM job_postings 
							WHERE job_postings.company_name IS NOT NULL
							GROUP BY job_postings.company_name  )
							ORDER BY cnt DESC
							LIMIT 5) As tbl")
			@companies = Array.new
			@pgrec.each do |p| @companies.push(p["company_name"]) end

			# Postgres query finds the most popular skill names (restricting length)
			@pgrec = ActiveRecord::Base.connection.execute("
					SELECT skills.name 
					FROM job_posting_skills, skills 
					WHERE job_posting_skills.skill_id = skills.id 
					  AND length(skills.name) < 50
					GROUP BY skills.name 
					ORDER BY COUNT(job_posting_skills.id) DESC 
					LIMIT 5")
			@skills = Array.new
			@pgrec.each do |s| @skills.push(s["name"]) end

			@locations = JobPosting.all.group(:location).order("COUNT(id) DESC").limit(5).pluck(:location)
			@dates_posted = ["1", "2-7", "8-14","15-30","30+"]
			@industries = JobCategory.all.pluck(:name)
			@job_types = JobPosting.get_types_collection.keys
		else # Search nothing
			idxs=[]
		end

		# Large block that modifies the where portion of the query
		if !@filters.blank?
			@filters.split(',').each do |f|
				case f
				when "location"
					if @type == "Companies"
						where_clause[:company_city] = @l.split(',')[0].strip
						where_clause[:company_province] = @l.split(',')[1].strip
					else
						where_clause[:location] = @l if !@l.blank?
					end
				when "industry"
					where_clause[:industry]=JobCategory.find_by(name:@i).id
				when "company"
					ids = User.where(company_name: @c).pluck(:id)
					if @type == "Companies"
						where_clause[:user_id]=ids
					elsif 
						where_clause[:company_name]=@c
						where_clause[:user_id]=ids if !ids.blank?
					end
				when "current_company"
					# To be implemented
					where_clause[:current_company]=@cc if !@cc.blank?
				when "past_company"
					# To be implemented
					where_clause[:past_company]=@pc if !@pc.blank?
				when "relationship"
					# To be implemented
					where_clause[:relationship]=@r if !@r.blank?
				when "skills"
					# To be implemented
					if @type == "People"
						where_clause[:skills]=@s if !@s.blank?
					elsif @type == "Projects"
						where_clause[:skills]=@s if !@s.blank?
					elsif @type == "JobPostings"
						where_clause[:skills]=@s if !@s.blank?
					end
				when "job_type"
					where_clause[:job_type]=JobPosting.get_types_collection[@jt] if !@jt.blank?
				when "date_posted"
					if !@dp.blank?
						if @dp == "1"
							where_clause[:created_at]={gte:Date.today-1}
						elsif @dp == "30+"
							where_clause[:created_at]={lte:Date.today-30}
						else
							@parts = @dp.split('-')
							where_clause[:created_at]={gte:Date.today-Integer(@parts[1]), lte:Date.today-Integer(@parts[0])}
						end
					end
				end
			end
		end

		# There is an N+1 query problem here with rolify
		@results = User.search @query, 
				 index_name: idxs,
				 operator: "or", 
				 track: {user_id:@usr,search_type:@type},
				 where: where_clause,
				 page: params[:page], per_page: 15

		@query = "" if @query == "*"

		# Need to fix remaining query filters.
		# Need to finish "Add" button filter option
		# Testing?
		# Merge
	end

	def navigate # Converts parameters to path and redirects to the object
		obj = params[:obj].constantize.find(params[:obj_id])
		Searchjoy::Search.find(params[:id]).convert(obj)
		redirect_to params[:path]
	end
end