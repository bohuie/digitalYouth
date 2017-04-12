class JobPostingsController < ApplicationController

	before_action :authenticate_user!, except: [:show, :index]
	before_action :check_employer, except: [:show, :index,:refresh,:refresh_process]
	before_action :check_admin	 , only: [:refresh,:refresh_process]
	before_action :job_owner	 , only: [:edit, :update, :destroy, :compare]
	#before_action :check_fields	 , only: [:create, :update]

	def index # Job Postings landing page

		if current_user.has_role? :employee
			@job_postings = JobPosting.all.order(views: :desc).limit(10)
			@reccommended_job_postings = reccomended_jobs
		else
			@job_postings = JobPosting.where(user_id: params[:user])
			@company = User.find(params[:user])
		end
	end

	def compare
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
		@job_posting = JobPosting.find(params[:id])
		@job_posting_applications = @job_posting.job_posting_applications.where("status > ? ", -1)
		@survey_results = Array.new
		average_results = Survey.get_average_data
		average_results.each do |index, avg|
			@survey_results[index] = Array.new if @survey_results[index].nil?
			@survey_results[index].push(name: "Average Job Seeker", data: avg)
		end

		ideal_results = Survey.get_table_data(@user, @job_posting)
		ideal_results.each do |index, results|
			@survey_results[index].push(name: 'Ideal Candidate', data: results)
		end
		
		@job_posting_applications.each do |j|
			user_results = Survey.get_table_data(j.applicant)
			user_results.each do |index, results|
				@survey_results[index].push(name: j.applicant.first_name+" "+j.applicant.last_name, data: results)
			end
		end
	end
	
	def show # Shows a specific job posting and its skills
		@job_posting = JobPosting.includes(:user,:job_category).find(params[:id])
		@company_name = @job_posting.company_name.nil? ? @job_posting.user.company_name : @job_posting.company_name
		@req_skills  = JobPostingSkill.where(job_posting_id:params[:id], importance: 2).includes(:skill).order(:id)
		@pref_skills = JobPostingSkill.where(job_posting_id:params[:id], importance: 1).includes(:skill).order(:id)
		add_view(@job_posting)
		@user = @job_posting.user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
		@surveys = Survey.get_title_map
		@survey_results = Survey.get_table_data(@user, @job_posting)
		@average_results = Survey.get_average_data

		if current_user == @user 
			@job_posting_applications = @job_posting.job_posting_applications.where("status > ? ", -1)
			@applicant_skills = Hash.new
			@job_posting_applications.each do |j|
				skills = @job_posting.compare_skills(j.applicant)
				user_skill_matches = skills[:user_skill_matches]
				@applicant_skills[j.applicant.id] = Hash.new
				@applicant_skills[j.applicant.id][:required] = user_skill_matches.select{ |a| a[:importance]==2 }
				@applicant_skills[j.applicant.id][:preferred] = user_skill_matches.select{ |a| a[:importance]==1 }
			end
		end
	end

	def new # Creates the form to make a new job posting
		@job_posting = JobPosting.new
		job_posting_skills = @job_posting.job_posting_skills.build
		job_posting_skills.skill = Skill.new
		@surveys = Survey.get_title_map
		@categories = JobCategory.all
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
	end

	def create # Creates a new job posting and skills
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
		@surveys = Survey.get_title_map
		@categories = JobCategory.all
		skip = false
		params[:job_posting][:user_id] = current_user.id

		if params[:job_posting][:pay_rate] == "yearly"
			params[:job_posting][:lower_pay_range] = params[:job_posting][:yearly_lower_pay_range]
			params[:job_posting][:upper_pay_range] = params[:job_posting][:yearly_upper_pay_range]
			@year_lower = params[:job_posting][:yearly_lower_pay_range]
			@year_upper = params[:job_posting][:yearly_upper_pay_range]
		elsif params[:job_posting][:pay_rate] == "hourly"
			params[:job_posting][:lower_pay_range] = params[:job_posting][:hourly_lower_pay_range]
			params[:job_posting][:upper_pay_range] = params[:job_posting][:hourly_upper_pay_range]
			@hour_lower = params[:job_posting][:hourly_lower_pay_range]
			@hour_upper = params[:job_posting][:hourly_upper_pay_range]
		else
			flash.now[:warning] = "Please select yearly or hourly for pay rate."
			skip = true
		end

		@job_posting = JobPosting.new(job_posting_params)
		if !skip && check_fields && @job_posting.save && @job_posting.process_skills(params[:job_posting]["job_posting_skills_attributes"])
			redirect_to current_user, flash: {success: "Job Posting Created!"}
			JobPosting.reindex if !Rails.env.test?
		else
			skill = Skill.new
			@job_posting.job_posting_skills.build(skill: skill)
			@jobskills = params[:job_posting]["job_posting_skills_attributes"]
			if flash[:warning].blank?
				flash.now[:warning] = "Oops, there was an issue in creating your Job Posting."
			end
			render 'new'
		end
	end

	def edit # Creates the form to edit a job posting
		@job_posting_skills = JobPostingSkill.where(job_posting_id:params[:id]).order(:id)
		@surveys = Survey.get_title_map
		@categories = JobCategory.all
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
		job_posting = JobPosting.find(params[:id])
		if job_posting.pay_rate == "yearly"
			@year_lower = job_posting.lower_pay_range
			@year_upper = job_posting.upper_pay_range
			@hour_lower
			@hour_upper
		else
			@year_lower
			@year_upper
			@hour_lower = job_posting.lower_pay_range
			@hour_upper = job_posting.upper_pay_range
		end
	end

	def update # Updates the job posting
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
		@surveys = Survey.get_title_map
		@categories = JobCategory.all
		skip = false
		if params[:job_posting][:pay_rate] == "yearly"
			params[:job_posting][:lower_pay_range] = params[:job_posting][:yearly_lower_pay_range]
			params[:job_posting][:upper_pay_range] = params[:job_posting][:yearly_upper_pay_range]
			@year_lower = params[:job_posting][:yearly_lower_pay_range]
			@year_upper = params[:job_posting][:yearly_upper_pay_range]
		elsif params[:job_posting][:pay_rate] == "hourly"
			params[:job_posting][:lower_pay_range] = params[:job_posting][:hourly_lower_pay_range]
			params[:job_posting][:upper_pay_range] = params[:job_posting][:hourly_upper_pay_range]
			@hour_lower = params[:job_posting][:hourly_lower_pay_range]
			@hour_upper = params[:job_posting][:hourly_upper_pay_range]
		else
			flash.now[:warning] = "Please select yearly or hourly for pay rate."
			skip = true
		end
		if !skip && check_fields && @job_posting.update_attributes(job_posting_params) && @job_posting.process_skills(params[:job_posting]["job_posting_skills_attributes"])
			redirect_to current_user, flash: {success: "Job Posting Updated!"}
			JobPosting.reindex if !Rails.env.test?
		else
			skill = Skill.new
			@job_posting_skill = JobPostingSkill.new(skill: skill)
			@jobskills = params[:job_posting]["job_posting_skills_attributes"]
			if flash[:warning].blank?
				flash.now[:warning] = "Oops, there was an issue in editing your Job Posting."
			end
			render 'edit'
		end
	end

	def destroy # Deletes the job posting from the database
		if @job_posting.destroy
			JobPosting.reindex if !Rails.env.test?
			redirect_to current_user, flash: {success: "Job Posting Deleted!"}
		else
			flash[:danger] = 'There was an error while deleting your Job Posting.'
			redirect_back_or current_user
		end
	end

	def refresh
		# Page to display the upload form for auto populating job postings
	end

	def refresh_process	# Takes in a .rb file and runs the file to refresh the auto populated job postings
		if !params[:job_posting_seeds].nil? and !params[:job_posting_seeds].tempfile.nil?
			puts "Deleting data.."
			ActiveRecord::Base.transaction do
				silence_stream(STDOUT) do
					@job_postings = JobPosting.where("company_name IS NOT NULL")
					@ids = @job_postings.pluck(:id)
					@job_postings.delete_all
					JobPostingSkill.where(job_posting_id: @ids).delete_all
				end
			end
			puts "Inserting data.."
			ActiveRecord::Base.transaction do
				silence_stream(STDOUT) do
					load params[:job_posting_seeds].tempfile
				end
			end
			JobPosting.reindex
			puts "Completed."
			redirect_to root_path, flash: {success: "Refreshed Auto Populated Job Postings"}
		else
			redirect_to refresh_job_posting_path, flash: {success: "Need to upload a file"}
		end
	end

private
	def job_posting_params # Restricts parameters
		params.require(:job_posting).permit(:title, :city, :province, :pay_rate, :lower_pay_range, :upper_pay_range, :link, :job_category_id, :posted_by, :description, :open_date, :close_date, :user_id, :job_type, :unit_number, :street_address, :postal_code)
	end

	def reccomended_jobs
		if user_signed_in? && current_user.has_role?(:employee)
			
			# Viewed Job Postings Query:
			#  Does not currently take into account the time spent on a page, or the age of the view
			#  Limits the views to be newer than a year
			#  ----------------------------------------
			#  Can improve the recommendation system by:
			#   Improving the selection weighting of time spent on a page vs its age
			#   Could also count the number of times a page view occurs and weight it by that too
			#   Limit to n number of job postings to use as the recommendation
			viewed_job_postings = ActiveRecord::Base.connection.execute("
						SELECT substring(properties->>'page', '[^/]*$') AS id 
						FROM ahoy_events 
						WHERE name = '$view_end' 
						  AND visit_id IN (SELECT visit_id FROM ahoy_events WHERE user_id = #{current_user.id})
						  AND properties ->> 'page' LIKE '/job_postings/%'
						").values.flatten # Does not currently take into account the times on each page or much of the age, could order by time spent on a page and limit results
			corpus = Array.new
			viewed_job_postings.each do |vjp|
				corpus << vjp unless vjp.to_i == 0 #catches applications pages
			end
			corpus << viewed_job_postings if !viewed_job_postings.empty?

			if !corpus.empty?
				corpus = JobPosting.find(corpus)
				corpus_arr = Array.new 
				#Add the viewed jobpostings to the corpus in the correct format
				corpus.each do |v|  
					corpus_arr.push({index: JobPosting.searchkick_index.name,id: v.id})
				end
				
				# Add the list of user_skills the user has entered to the corpus
				# Can be removed if needed. Added to try to make the recommendations closer to the users potential preferences
				#corpus_arr.push(current_user.skills.pluck(:name))

				results = JobPosting.search more_like_this: {
									fields: [:industry],
									like: corpus_arr,
									min_term_freq: 1
						        }, per_page: 10
			end

			return results
		else 
			return nil
		end
	end

	# This method should be moved to a more general class or location (Don't know the best place to put it)
	def get_stop_word_array
		return ['a','about','above','after','again','against','all','am','an','and','any','are',"aren't",'as','at','be','because','been','before','being','below','between','both','but','by',
				"can't",'cannot','could',"couldn't",'did',"didn't",'do','does',"doesn't",'doing',"don't",'down','during','each','few','for','from','further','had',"hadn't",'has',"hasn't",
				'have',"haven't",'having','he',"he'd","he'll","he's",'her','here',"here's",'hers','herself','him','himself','his','how',"how's",'i',"i'd","i'll","i'm","i've",'if','in','into',
				'is',"isn't",'it',"it's",'its','itself',"let's",'me','more','most',"mustn't",'my','myself','no','nor','not','of','off','on','once','only','or','other','ought','our','ours',
				'ourselves','out','over','own','same',"shan't",'she',"she'd","she'll","she's",'should',"shouldn't",'so','some','such','than','that',"that's",'the','their','theirs','them',
				'themselves','then','there',"there's",'these','they',"they'd","they'll","they're","they've",'this','those','through','to','too','under','until','up','very','was',"wasn't",
				'we',"we'd","we'll","we're","we've",'were',"weren't",'what',"what's",'when',"when's",'where',"where's",'which','while','who',"who's",'whom','why',"why's",'with',"won't",
				'would',"wouldn't",'you',"you'd","you'll","you're","you've",'your','yours','yourself','yourselves','zero']
	end

	def check_employer # Checks current user is an employer
		if !current_user.has_role? :employer
			flash[:warning] = 'You must be a job provider to do that action.'
			redirect_back_or current_user
		end
	end

	def check_admin # Checks current user is an admin
		if !current_user.has_role? :admin
			flash[:danger] = 'Admins only.'
			redirect_back_or current_user
		end
	end

	def job_owner # Checks current user is the Job Posting owner
		@job_posting = JobPosting.find(params[:id])
		if @job_posting.user_id != current_user.id
			flash[:danger] = 'You can only make changes to your Job Posting'
			redirect_back_or current_user
		else
			return @job_posting
		end
	end

	def add_view(job_posting) # Checks to make sure the user doesn't own the posting and hasn't seen it this session
		return nil if (user_signed_in? && @job_posting.user_id == current_user.id)||(job_posting.is_expired?)
		session[:job_posting_views] = Array.new if session[:job_posting_views].nil?
		if !session[:job_posting_views].include? job_posting.id
			job_posting.update(views: @job_posting.views+1)
			session[:job_posting_views].push(job_posting.id)
		end
	end

	def check_fields # Performs rigorous checks to ensure that the job posting is valid
		args = params[:job_posting]
		if args["job_posting_skills_attributes"].nil?
			@job_posting.errors.add(:job_posting_skills, "must have at least one skill")
			flash.now[:warning] = "You must enter some skills associated with this job."
		elsif !args["job_posting_skills_attributes"].nil?
			destroy = true
			missing = false
			args["job_posting_skills_attributes"].each do |index, m|
				
				if m["_destroy"] == "false"
					destroy = false 
					if m["skill_attributes"]["name"].blank?
						missing = true 
						@job_posting.errors[:skill][index.to_i] = {} if @job_posting.errors[:skill][index.to_i].blank?
						@job_posting.errors[:skill][index.to_i][:name] = "must have a name."
					end
					if m["survey_id"].blank?
						missing = true 
						@job_posting.errors[:skill][index.to_i] = {} if @job_posting.errors[:skill][index.to_i].blank?
						@job_posting.errors[:skill][index.to_i][:survey_id] = "must select a skill category." 
					end
					if m["importance"].blank?
						missing = true 
						@job_posting.errors[:skill][index.to_i] = {} if @job_posting.errors[:skill][index.to_i].blank?
						@job_posting.errors[:skill][index.to_i][:importance] = "must select an importance."
					end
				end
			end
			if missing
				flash.now[:warning] = "You must enter all skill fields."
			end

			if destroy
				@job_posting.errors.add(:job_posting_skills, "must have at least one skill")
				flash.now[:warning] = "You must enter some skills associated with this job." 
			end
		end
		if !flash[:warning].blank?
			return false 
		else
			return true
		end

		#redirect_back_or job_postings_path if !flash[:warning].blank?
	end
end