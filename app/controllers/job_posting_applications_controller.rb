class JobPostingApplicationsController < ApplicationController

	before_action :authenticate_user!
	before_action :check_employee, only: [:new, :create]
	before_action :check_applied, only: [:new, :create]
	before_action :check_association, only: [:show]
	before_action :check_applicant, only: [:destroy]
	before_action :check_company, only: [:update]

	def index # Show a users job applications (either a employer or employee)
		if current_user.has_role? :employee
			@job_posting_applications = JobPostingApplication.where(applicant_id:current_user.id)
		elsif current_user.has_role? :employer
			if params[:job_posting].blank?
				@job_posting_applications = JobPostingApplication.where(company_id:current_user.id)
			else
				@job_posting_applications = JobPostingApplication.where(company_id:current_user.id,job_posting_id:params[:job_posting])
			end
		end
	end

	def show # Show the information of an application
		#@job_posting_application is retrieved in the check_association method
	end

	def new
		@job_posting = JobPosting.find(params[:job_posting])
		if !@job_posting.is_expired?
			@job_posting_application = JobPostingApplication.new
		else
			flash[:warning] = 'You cannot apply for an expired posting.'
			redirect_back_or job_posting_path(@job_posting)
		end
	end

	def create
		params[:job_posting_application][:applicant_id] = current_user.id
		@job_posting_application = JobPostingApplication.new(job_posting_application_params)
		if @job_posting_application.save
			redirect_to job_posting_applications_path, flash: {success: "Application Sent!"}
		else
			flash[:warning] = "Oops, there was an issue in sending your application."
			redirect_back_or job_posting_path(params[:job_posting_id])
		end
	end

	def destroy
		#delete the application
		#@job_posting_application is retrieved in the check_applicant method
		# Shouldn't actually delete it, should set a deleted flag to true to still ensure that people can't reapply.
	end


private
	def job_posting_application_params # Restricts parameters
		params.require(:job_posting_application).permit(:message, :applicant_id, :company_id, :job_posting_id)
	end
	def check_employee # Checks current user is an employee
		if !current_user.has_role? :employee
			flash[:warning] = 'You are not an employee!'
			redirect_back_or current_user
		end
	end

	def check_association # Checks current user is the company
		@job_posting_application = JobPostingApplication.find(params[:id])
		if @job_posting_application.company_id!=current_user.id and @job_posting_application.applicant_id!=current_user.id
			flash[:danger] = 'Action denied. You are not associated with this application'
			redirect_back_or current_user
		else
			return @job_posting_application
		end
	end

	def check_applicant # Checks current user is the applicant
		@job_posting_application = JobPostingApplication.find(params[:id])
		if @job_posting_application.applicant_id != current_user.id
			flash[:danger] = 'Action denied. You must be the applicant.'
			redirect_back_or current_user
		else
			return @job_posting_application
		end
	end

	def check_company # Checks current user is the company
		@job_posting_application = JobPostingApplication.find(params[:id])
		if @job_posting_application.company_id != current_user.id
			flash[:danger] = 'Action denied. You must be the company associated with this application.'
			redirect_back_or current_user
		else
			return @job_posting_application
		end
	end

	def check_applied
		#Should also add a check to make it so they can reapply after a long long time.
		posting_id = params[:job_posting].blank? ? params[:job_posting_application][:job_posting_id] : params[:job_posting]
		if !JobPostingApplication.where(applicant_id: current_user.id, job_posting_id: posting_id).first.nil?
			flash[:warning] = 'You have already applied for this position.'
			redirect_back_or job_posting_path(posting_id)
		end
	end
end
