class ResponsesController < ApplicationController
	include ConstantHelper

	before_action :authenticate_user!
	before_action :check_role

	def create
		# Fetch data from params
		@user = current_user
		@survey_id = Integer(params[:response][:survey_id])
		@scores = params[:response][:scores]
		@question_ids = params[:response][:question_ids]

		# Check to see if the survey is unanswered for the user and make a new response if its unanswered
		if @user.answered_surveys[@survey_id - 1] == false
			@response = Response.new(user_id: @user.id, survey_id: @survey_id)
		else # Prevent users from entering duplicates when hitting back after creating a response
			@response = Response.find_by(user_id: @user.id, survey_id: @survey_id)
		end

		#Record response to database
		@response.set_data_from_hash(@scores,@question_ids)
		if !@response.save
			redirect_to current_user, flash: {danger: "There was an issue saving your response"}
		end
		#Record that the user has answered the survey
		@user.answered_surveys[@survey_id - 1] = true
		if !@user.save
			@response.destroy # The survey wasn't marked properly in the user table, response is destroyed.
			redirect_to current_user, flash: {danger: "There was an issue saving your response"}
		end
		redirect_to current_user, flash: {success: "Thanks for answering the survey!"}
	end

	def update
		# Fetch data from params
		@user = current_user
		@survey_id = Integer(params[:response][:survey_id])
		@scores = params[:response][:scores]
		@question_ids = params[:response][:question_ids]
		
		# Update the record
		@response = Response.find_by(user_id: @user.id, survey_id: @survey_id)
		@response.set_data_from_hash(@scores,@question_ids)
		if !@response.save
			redirect_to current_user, flash: {danger: "There was an issue saving your response"}
		end
		redirect_to current_user, flash: {success: "Thanks for answering the survey!"}
	end

private
	def check_role
		if !current_user.has_role? :employee
			redirect_to current_user, flash: {warning: "You need to be an employee or a potential employee to perform a survey"}
		end
	end
end
