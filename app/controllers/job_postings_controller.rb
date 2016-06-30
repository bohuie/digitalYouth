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
		@req_skills = Skill.where(id: JobPostingSkill.select("skill_id").where(job_posting_id:params[:id], importance: 2))
		@pref_skills = Skill.where(id: JobPostingSkill.select("skill_id").where(job_posting_id:params[:id], importance: 1))
	end

	def new
		if current_user.has_role? :employer
			@job_posting = JobPosting.new
		else
			redirect_to current_user, flash: {warning: "You are not an employer!"}
		end
	end

	def create
		params[:job_posting][:user_id] = current_user.id
		@job_posting = JobPosting.new(job_posting_params)
		if @job_posting.save
			redirect_to current_user, flash: {success: "Job Posting Created!"}
		else
			render current_user, flash: {warning: "Oops, there was an issue in creating your Job Posting."}
		end
	end

	def edit
		#@job_posting is found in the job_owner method
		@req_skills = Skill.where(id: JobPostingSkill.select("skill_id").where(job_posting_id:params[:id], importance: 2))
		@pref_skills = Skill.where(id: JobPostingSkill.select("skill_id").where(job_posting_id:params[:id], importance: 1))
		@questions = Question.all.includes(:survey)
		@skills = Skill.all
	end

	def update
		#@job_posting is found in the job_owner method
		if @job_posting.update_attributes(job_posting_params)
			redirect_to @job_posting, flash: {success: "Job Posting Updated!"}
		else
			render 'edit', flash: {warning: "Oops, there was an issue in editing your Job Posting."}
		end
	end

	def destroy
		#@job_posting is found in the job_owner method
		@job_posting.destroy
		redirect_to job_postings_path, flash: {success: "Job Posting deleted!"}
	end

	private
	def job_posting_params
		params.require(:job_posting).permit(:title, :location, :pay_range, :link, :posted_by, :description, :open_date, :close_date, :user_id)
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
		if args[:title].blank? || args[:location].blank? || args[:description].blank? || args[:open_date].blank? || args[:close_date].blank?
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
end