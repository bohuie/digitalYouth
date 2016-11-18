class JobPostingApplicationsController < ApplicationController

	before_action :authenticate_user!
	before_action :check_employee	, only: [:new, :create]
	before_action :check_applied	, only: [:new, :create]
	before_action :check_applicant	, only: [:destroy]
	before_action :check_association, only: [:show]
	before_action :check_company	, only: [:update]

	def index # Show a users job applications (either a employer or employee)
		if current_user.has_role? :employee
			@job_posting_applications = JobPostingApplication.where(applicant_id:current_user.id, status:-1..Float::INFINITY).order(status: :desc).includes(:job_posting)
		elsif current_user.has_role? :employer
			if params[:job_posting].blank?
				@job_posting_applications = JobPostingApplication.where(company_id:current_user.id, status:-1..Float::INFINITY).order(status: :desc).includes(:applicant,:job_posting)
			else
				@job_posting_applications = JobPostingApplication.where(company_id:current_user.id, status:-1..Float::INFINITY,job_posting_id:params[:job_posting]).order(status: :desc).includes(:applicant,:job_posting)
			end
		end
		@user = current_user
	end

	def show # Show the information of an application
		@job_posting = @job_posting_application.job_posting
		if current_user.has_role? :employer 
			skills = @job_posting.compare_skills(@job_posting_application.applicant)
			@user_skill_matches = skills[:user_skill_matches]
			@response_skill_matches = skills[:response_skill_matches]
			@project_skill_matches = skills[:project_skill_matches]
		end
		@user = current_user
	end

	def new # Displays the forum to create an application
		@user = current_user
		@job_posting = JobPosting.find(params[:job_posting])
		if !@job_posting.is_expired?
			@job_posting_application = JobPostingApplication.new
		else
			flash[:warning] = 'You cannot apply for an expired posting.'
			redirect_back_or job_posting_path(@job_posting)
		end
	end

	def create # Creates the application
		params[:job_posting_application][:applicant_id] = current_user.id
		@job_posting_application = JobPostingApplication.new(job_posting_application_params)
		if @job_posting_application.save
			#Create notification for company
			@job_posting_application.create_activity :create,  owner: @job_posting_application.company
			redirect_to current_user, flash: {success: "Application Sent!"}
		else
			flash[:warning] = "Oops, there was an issue in sending your application."
			redirect_back_or job_posting_path(params[:job_posting_id])
		end
	end

	def update # Set the status to the value matching the parameter
		save = @job_posting_application.update(status: JobPostingApplication.get_status_int(params[:status]))
		if save #Create notification for user
			@job_posting_application.create_activity :update, owner: @job_posting_application.applicant, parameters: {status: status}
			redirect_to job_posting_applications_path, flash: {success: "Updated Application Status!"}
		else
			flash[:warning] = "Oops, there was an issue in updating that application."
			redirect_back_or job_posting_application_path(params[:id])
		end
	end

	def destroy
		save = @job_posting_application.update(status: -2)
		if save # Destroy notifications
			PublicActivity::Activity.where(trackable_id:(params[:id]),trackable_type:controller_path.classify).each {|a| a.destroy}
			redirect_to job_posting_applications_path, flash: {success: "Deleted Application!"}
		else
			flash[:warning] = "Oops, there was an issue in deleting that application."
			redirect_back_or 
		end
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

	def check_applied # Checks if the user has already applied for a jobposting
		posting_id = params[:job_posting].blank? ? params[:job_posting_application][:job_posting_id] : params[:job_posting]
		if !JobPostingApplication.where(applicant_id: current_user.id, job_posting_id: posting_id).first.nil?
			flash[:warning] = 'You have already applied for this position.'
			redirect_back_or
		end
	end
end