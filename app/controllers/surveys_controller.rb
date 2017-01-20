class SurveysController < ApplicationController
	include ConstantHelper

	before_action :authenticate_user!, except: [:show]
	before_action :check_role_jobseeker, only: [:edit]
	before_action :check_role_employer, only: [:compare]
	before_action :job_owner, only: [:compare]
	
	def show
		@survey = Survey.find_by(title: params[:title])
		@user = User.find(params[:user])
		if @survey.nil? || @user.nil?
			flash[:warning] = "Sorry, we couldn't find that survey for that user."
			redirect_back_or and return
		end

		@survey_results = Array.new

		@survey_results.push(name: "Average Job Seeker", data: @survey.get_average_data)
		@survey_results.push(name: @user.first_name+" "+@user.last_name, data: @survey.get_data(@user))
		@questions = @survey.questions

		@prompts = Hash.new
		@questions.each do |q|
			@prompts = @prompts.merge({q.id => q.prompts})
		end
	end

	def edit
		# Fetch Survey data
		@survey = Survey.find_by(title: params[:title])
		if @survey.nil?
			flash[:warning] = "Sorry, we couldn't find that survey."
			redirect_back_or and return
		end	
		@survey_results = @survey.get_data(current_user)
		@average_results = @survey.get_average_data
		@questions = @survey.questions
		@question_count = @questions.count
		@method = "post"
		@score_meanings = get_meanings(@survey.title)

		# Map the prompts to the questions
		@prompts = Hash.new
		@questions.each do |q|
			@prompts = @prompts.merge({q.id => q.prompts})
		end

		# Setup the Response variables
		@response = Response.new
		@values_array = Array.new(@question_count, 0)

		# Generates a collection array to remove labels
		@collection_array = Array.new()
		for i in 0..Integer(max_rating)
			@collection_array.push([i,''])
		end	
	
		# Load data if it exists
		@data = Response.find_by(user_id: current_user.id, survey_id: @survey.id)
		if @data != nil
			@method = "patch"
			@values_array = @data.scores
		end
	end

	def compare
		@survey = Survey.find_by(title: params[:title])
		if @survey.nil?
			flash[:warning] = "Sorry, we couldn't find that survey."
			redirect_back_or and return
		end	

		@questions = @survey.questions
		@survey_results = Array.new

		@survey_results.push(name: "Average Job Seeker", data: @survey.get_average_data)

		@job_posting_applications = @job_posting.job_posting_applications.where("status > ? ", -1)
		@job_posting_applications.each do |j|
			user_results = @survey.get_data(j.applicant)
			if user_results
				@survey_results.push(name: j.applicant.first_name+" "+j.applicant.last_name, data: user_results)
			end
		end

		@prompts = Hash.new
		@questions.each do |q|
			@prompts = @prompts.merge({q.id => q.prompts})
		end
	end

private
	def check_role_jobseeker
		if !current_user.has_role? :employee
			redirect_to current_user, flash: {warning: "You need to be a job seeker or a potential job seeker to perform a survey."}
		end
	end

	def check_role_employer
		if !current_user.has_role? :employer
			redirect_to current_user, flash: {warning: "You need to be an employer to compare applicants."}
		end
	end

	def job_owner # Checks current user is the Job Posting owner
		@job_posting = JobPosting.find(params[:job_posting])
		if @job_posting.user_id != current_user.id
			flash[:danger] = 'You can only compare applicants on your own job posting.'
			redirect_back_or
		else
			return @job_posting
		end
	end
end
