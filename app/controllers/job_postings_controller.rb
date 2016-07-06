class JobPostingsController < ApplicationController

	before_action :authenticate_user!, except: [:show, :index]
	before_action :job_owner, only: [:edit, :update, :destroy]
	before_action :check_fields, only: [:create, :update]

	def index
		if params[:user].nil?
			params[:user] = current_user if current_user.has_role? :employer
		end
		@job_postings = JobPosting.where(user_id: params[:user])
		@company = User.find(params[:user])
	end
	
	def show
		@job_posting = JobPosting.find(params[:id])
		@company = User.find(@job_posting.user_id)
		@req_skills  = JobPostingSkill.where(job_posting_id:params[:id], importance: 2).includes(:skill)
		@pref_skills = JobPostingSkill.where(job_posting_id:params[:id], importance: 1).includes(:skill)
	end

	def new
		if current_user.has_role? :employer
			@job_posting = JobPosting.new
			job_posting_skills = @job_posting.job_posting_skills.build
			job_posting_skills.skill = Skill.new
			
			@questions = get_questions_label_map
			@skills = Skill.all
		else
			redirect_to current_user, flash: {warning: "You are not an employer!"}
		end
	end

	def create
		params[:job_posting][:user_id] = current_user.id
		@job_posting = JobPosting.new(job_posting_params)
		if @job_posting.save
			redir_flag = process_skills(params[:job_posting]["job_posting_skills_attributes"],@job_posting.id)
		else
			redir_flag = true
		end

		if !redir_flag
			redirect_to current_user, flash: {success: "Job Posting Created!"}
		else
			render current_user, flash: {warning: "Oops, there was an issue in creating your Job Posting."}
		end
	end

	def edit #@job_posting is found in the job_owner method
		@job_posting_skills = JobPostingSkill.where(job_posting_id:params[:id]) 
		@questions = get_questions_label_map
		@skills = Skill.all
	end

	def update #@job_posting is found in the job_owner method
		redir_flag = process_skills(params[:job_posting]["job_posting_skills_attributes"],@job_posting.id)
		if @job_posting.update_attributes(job_posting_params) && !redir_flag
			redirect_to @job_posting, flash: {success: "Job Posting Updated!"}
		else
			render 'edit', flash: {warning: "Oops, there was an issue in editing your Job Posting."}
		end
	end

	def destroy #@job_posting is found in the job_owner method
		@job_posting.destroy 
		redirect_to job_postings_path, flash: {success: "Job Posting deleted!"}
	end

	def skill_autocomplete
		@skills = Skill.order(:name).where("name LIKE ?", "%#{params[:term]}%")
		@skills.each {|s| s.name.capitalize!}
	    respond_to do |format|
	      format.html
	      format.json { 
	        render json: @skills.map(&:name).to_json
	      }
   		end
	end

private
	def job_posting_params
		params.require(:job_posting).permit(:title, :location, :pay_range, :link, :category, :posted_by, :description, :open_date, :close_date, :user_id)
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

	def check_fields
		args = params[:job_posting]
		if args[:title].blank? || args[:location].blank? || args[:description].blank? || args[:open_date].blank? || args[:close_date].blank? || args[:category].blank?
			flash[:warning] = 'Missing required fields'
			redirect_back_or job_postings_path
		elsif args[:location].split(',').length != 2 || args[:location].split(',')[1].strip.length > 2
			flash[:warning] = 'Location must in the form: City , Province Code'
			redirect_back_or job_postings_path
		elsif args[:open_date] > args[:close_date]
			flash[:warning] = 'Open date must be before close date'
			redirect_back_or job_postings_path
		end
	end

	def get_questions_label_map
		rtn = Hash.new
		questions = Question.all.includes(:survey)
		questions.each do |q|
			title = q.survey.category + ": " + q.survey.title + ": " + q.classification  
			rtn[title] = q.id
		end
		return rtn
	end

	def process_skills(hash,job_posting_id)
		hash.each do |h|
			id = h[1]["id"]
			if h[1]["_destroy"] == "true" && !id.blank?
				JobPostingSkill.find(id).destroy
			elsif h[1]["_destroy"] == "false"
				skill_name = h[1]["skill_attributes"]["name"].downcase
				skill = Skill.find_by(name: skill_name)
				if skill.nil?
					skill = Skill.new(name: skill_name)
					return true if !skill.save
				end
				skill_id = skill.id
				question_id = h[1]["question_id"]
				importance = h[1]["importance"]
			end

			if id.blank?
				job_posting_skill = JobPostingSkill.new(skill_id: skill_id, question_id: question_id, importance: importance, job_posting_id: job_posting_id)
				return true if !job_posting_skill.save
			else
				job_posting_skill = JobPostingSkill.find(id)
				return true if !job_posting_skill.update(skill_id: skill_id, question_id: question_id, importance: importance, job_posting_id: job_posting_id)
			end
		end

		return false
	end
end