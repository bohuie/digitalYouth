class JobPostingsController < ApplicationController

	def new
		@job_posting
	end

	def show
		@job_posting = JobPosting.find(params[:id])
	end

	def edit
		@job_posting = JobPosting.find(params[:id])
	end

	def create
		@job_posting = current_user.job_postings.build(job_posting_params)
		if @job_posting.save
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
end
