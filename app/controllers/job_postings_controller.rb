class JobPostingsController < ApplicationController

	before_action :authenticate_user!, except: [:show]
	before_action :job_owner, only: [:edit, :update, :destroy]
	
	def new
		@job_posting = JobPosting.new
	end

	def show
		@job_posting = JobPosting.find(params[:id])
		@req_skills = Skill.where(id: JobPostingSkill.select("skill_id").where(job_posting_id:params[:id], importance: 2))
		@pref_skills = Skill.where(id: JobPostingSkill.select("skill_id").where(job_posting_id:params[:id], importance: 1))
	end

	def edit
		@job_posting = JobPosting.find(params[:id])
	end

	def create
		@job_posting = JobPosting.new(job_posting_params)
		if @job_posting.save
			current_user << @job_posting
			redirect_to current_user
		else
			render current_user
		end
	end

	def update
		@job_posting = JobPosting.find(params[:id])
		if @job_posting.update_attributes(job_posting_params)
			redirect_to current_user
		else
			render 'edit'
		end
	end

	private
	def job_posting_params
		params.require(:job_posting).permit(:title, :description, :open_date, :close_date)
	end

	def job_owner
		@job = Job.find(params[:id])
		
		unless @job.user_id == current_user.id
			flash[:notice] = 'Access denied as you are not owner of this Job'
			redirect_to current_user
		end
	end
end
