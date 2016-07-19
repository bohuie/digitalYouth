class JobPostingsController < ApplicationController

	before_action :authenticate_user!, except: [:show, :index]
	before_action :check_employer, except: [:show, :index]
	before_action :job_owner, only: [:edit, :update, :destroy]
	before_action :check_fields, only: [:create, :update]

	def index # Lists all job_postings a company has.
		params[:user] = current_user if current_user.has_role? :employer if params[:user].nil?
		@job_postings = JobPosting.where(user_id: params[:user])
		@company = User.find(params[:user])
	end
	
	def show # Shows a specific job posting and its skills
		@job_posting = JobPosting.includes(:user,:job_category).find(params[:id])
		@job_posting.company_name = @job_posting.user.company_name if @job_posting.company_name.nil?
		@req_skills  = JobPostingSkill.where(job_posting_id:params[:id], importance: 2).includes(:skill)
		@pref_skills = JobPostingSkill.where(job_posting_id:params[:id], importance: 1).includes(:skill)
		add_view(@job_posting)
	end

	def new # Creates the form to make a new job posting
		@job_posting = JobPosting.new
		job_posting_skills = @job_posting.job_posting_skills.build
		job_posting_skills.skill = Skill.new
		@questions = Question.get_label_map
		@skills = Skill.all
	end

	def create # Creates a new job posting and skills
		params[:job_posting][:user_id] = current_user.id
		category = set_category(params[:job_posting][:job_category])
		params[:job_posting][:job_category_id] = category.id if !category.nil?
		@job_posting = JobPosting.new(job_posting_params)
		if !category.nil? && @job_posting.save && process_skills(params[:job_posting]["job_posting_skills_attributes"],@job_posting.id)
			redirect_to job_postings_path, flash: {success: "Job Posting Created!"}
		else
			flash[:warning] = "Oops, there was an issue in creating your Job Posting."
			redirect_back_or current_user
		end
	end

	def edit # Creates the form to edit a job posting
		@job_posting_skills = JobPostingSkill.where(job_posting_id:params[:id])
		@questions = Question.get_label_map
		@skills = Skill.all
	end

	def update # Updates the job posting
		category = set_category(params[:job_posting][:job_category])
		params[:job_posting][:job_category_id] = category.id if !category.nil?
		if !category.nil? && @job_posting.update_attributes(job_posting_params) && process_skills(params[:job_posting]["job_posting_skills_attributes"],@job_posting.id)
			redirect_to @job_posting, flash: {success: "Job Posting Updated!"}
		else
			redirect_to edit_job_posting_path, flash: {warning: 'Oops, there was an issue in editing your Job Posting.'}
		end
	end

	def destroy # Deletes the job posting from the database
		if @job_posting.destroy
			redirect_to job_postings_path, flash: {success: "Job Posting deleted!"}
		else
			flash[:danger] = 'There was an error while deleting your Job Posting.'
			redirect_back_or job_postings_path
		end
	end

private
	def job_posting_params # Restricts parameters
		params.require(:job_posting).permit(:title, :location, :pay_range, :link, :job_category_id, :posted_by, :description, :open_date, :close_date, :user_id)
	end

	def check_employer # Checks current user is an employer
		if !current_user.has_role? :employer
			flash[:warning] = 'You are not an employer!'
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

	def set_category(name) # Checks to see if the category exists, creates if it doesn't exist
		category = JobCategory.find_by(name: name)
		if category.nil?
			category = JobCategory.new(name: name)
			return nil if !category.save #If Save fails method returns nil
		end
		return category
	end

	def add_view(job_posting) # Checks to make sure the user doesn't own the posting and hasn't seen it this session
		return nil if user_signed_in? && @job_posting.user_id == current_user.id
		session[:job_posting_views] = Array.new if session[:job_posting_views].nil?
		if !session[:job_posting_views].include? job_posting.id
			job_posting.update(views: @job_posting.views+1)
			session[:job_posting_views].push(job_posting.id)
		end
	end

	def check_fields # Performs rigorous checks to ensure that the job posting is valid
		args = params[:job_posting]
		if args[:title].blank? || args[:location].blank? || args[:description].blank? || args[:open_date].blank? || args[:close_date].blank? || args[:job_category].blank?
			flash[:warning] = "Missing required fields"
			redir = true
		elsif args[:location].split(',').length != 2 || args[:location].split(',')[1].strip.length > 2
			flash[:warning] = "Location must in the form: City , Province Code"
		elsif args[:open_date] > args[:close_date]
			flash[:warning] ="Open date must be before close date"
		elsif args["job_posting_skills_attributes"].nil?
			flash[:warning] = "You must enter some skills associated with this job."
		elsif !args["job_posting_skills_attributes"].nil?
			destroy = true
			missing = false
			args["job_posting_skills_attributes"].each do |m|
				missing = true if m[1]["skill_attributes"]["name"].blank?
				missing = true if m[1]["question_id"].blank?
				missing = true if m[1]["importance"].blank?
				destroy = false if m[1]["_destroy"] == "false"
			end
			flash[:warning] = "You must enter all skill fields." if missing
			flash[:warning] = "You must enter some skills associated with this job." if destroy
		end
		redirect_back_or job_postings_path if redir || missing || destroy
	end

	def process_skills(hash,job_posting_id) # Creates and Updates job posting skills, creating new skills when needed.
		hash.each do |m|
			id = m[1]["id"]
			if m[1]["_destroy"] == "true"
				JobPostingSkill.find(id).destroy if !id.blank?
			elsif m[1]["_destroy"] == "false"
				skill_name = m[1]["skill_attributes"]["name"].downcase
				skill = Skill.find_by(name: skill_name)
				if skill.nil?
					skill = Skill.new(name: skill_name)
					return false if !skill.save
				end
				skill_id = skill.id
				question_id = m[1]["question_id"]
				importance = m[1]["importance"]

				if id.blank?
					job_posting_skill = JobPostingSkill.new(skill_id: skill_id, question_id: question_id, importance: importance, job_posting_id: job_posting_id)
					return false if !job_posting_skill.save
				else
					job_posting_skill = JobPostingSkill.find(id)
					return false if !job_posting_skill.update(skill_id: skill_id, question_id: question_id, importance: importance, job_posting_id: job_posting_id)
				end
			end
		end
		return true
	end
end