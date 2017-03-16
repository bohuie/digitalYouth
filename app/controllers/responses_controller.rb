class ResponsesController < ApplicationController
	include ConstantHelper

	before_action :authenticate_user!
	#before_action :check_role

	def create
		# Fetch data from params
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
		@survey_id = Integer(params[:response][:survey_id])
		@scores = params[:response][:scores]
		@question_ids = params[:response][:question_ids]

		if current_user.has_role? :employee
			# Check to see if the survey is unanswered for the user and make a new response if its unanswered
			if @user.answered_surveys[@survey_id - 1] == false
				@response = Response.new(user_id: @user.id, survey_id: @survey_id)
			else # Prevent users from entering duplicates when hitting back after creating a response
				@response = Response.find_by(user_id: @user.id, survey_id: @survey_id)
			end
		elsif current_user.has_role? :employer
			@job_posting = JobPosting.find(params[:response][:job_posting_id])
			if @job_posting.nil?
				flash[:warning] = "Sorry, we couldn't find that job posting."
				redirect_to current_user and return
			end
			if @job_posting.answered_surveys[@survey_id - 1] == false
				@response = Response.new(user_id: @user.id, survey_id: @survey_id, job_posting_id: @job_posting.id)
			else # Prevent users from entering duplicates when hitting back after creating a response
				@response = Response.find_by(user_id: @user.id, survey_id: @survey_id, job_posting_id: @job_posting.id)
			end
		else
			flash[:warning] = "Sorry, something happened.  Please contact an administrator."
			redirect_to current_user and return
		end

		#Record response to database
		@response.set_data_from_hash(@scores,@question_ids)
		if !@response.save
			redirect_to current_user, flash: {danger: "There was an issue saving your response"} and return
		end
		#Record that the user has answered the survey
		if current_user.has_role? :employee
			@user.answered_surveys[@survey_id - 1] = true
			if !@user.save
				@response.destroy # The survey wasn't marked properly in the user table, response is destroyed.
				redirect_to current_user, flash: {danger: "There was an issue saving your response"} and return
			end
		elsif current_user.has_role? :employer
			@job_posting.answered_surveys[@survey_id - 1] = true
			if !@job_posting.save
				@response.destroy # The survey wasn't marked properly in the user table, response is destroyed.
				redirect_to @job_posting, flash: {danger: "There was an issue saving your response"} and return
			end
		end
		if current_user.has_role? :employee
			redirect_to current_user, flash: {success: "Thanks for answering the survey!"}
		elsif current_user.has_role? :employer
			redirect_to @job_posting, flash: {success: "Thanks for answering the survey!"}
		end
	end

	def update
		# Fetch data from params
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
		@survey_id = Integer(params[:response][:survey_id])
		@scores = params[:response][:scores]
		@question_ids = params[:response][:question_ids]
		
		if current_user.has_role? :employee
			@response = Response.find_by(user_id: @user.id, survey_id: @survey_id)
		elsif current_user.has_role? :employer
			@job_posting = JobPosting.find(params[:response][:job_posting_id])
			if @job_posting.nil?
				flash[:warning] = "Sorry, we couldn't find that job posting."
				redirect_to current_user and return
			end
			@response = Response.find_by(user_id: @user.id, survey_id: @survey_id, job_posting_id: @job_posting.id)
		end
		
		# Update the record
		@response.set_data_from_hash(@scores,@question_ids)
		if !@response.save
			if current_user.has_role? :employee
				redirect_to current_user, flash: {danger: "There was an issue saving your response"}
			elsif current_user.has_role? :employer
				redirect_to @job_posting, flash: {danger: "There was an issue saving your response"}
			end
		end
		if current_user.has_role? :employee
			redirect_to current_user, flash: {success: "Thanks for answering the survey!"}
		elsif current_user.has_role? :employer
			redirect_to @job_posting, flash: {success: "Thanks for answering the survey!"}
		end
	end

private
	def check_role
		if !current_user.has_role? :employee
			redirect_to current_user, flash: {warning: "You need to be an employee or a potential employee to perform a survey"}
		end
	end
end
