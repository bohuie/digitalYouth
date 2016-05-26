class SurveysController < ApplicationController

	before_action :authenticate_user!

	def show
		#Builds variables for the Survey page to display all information correctly
		@survey = Survey.find(params[:id])
		@questions = @survey.questions
		
		@prompts = Hash.new
		@questions.each do |q|
			@prompts = @prompts.merge({q.id => q.prompts})
			q.responses.build #This is causing horrible issues where multiples of the radio buttons are built
		end
	end

	def create
		#Fetch the responses to each question
		@responses = params[:survey][:questions_attributes]
		@user = current_user

		#For each response add it to the database
		@responses.each do |r| 
			r = r.last
			@response = Response.create(score: r[:responses_attributes][:"0"][:score], user_id: @user.id, question_id: r[:id])
		end
		
		
		#Record that the user has answered the survey
		@survey_id = Integer(params[:survey][:id])
		@user.answered_surveys[@survey_id - 1] = true
		User.find(@user.id).update(answered_surveys: @user.answered_surveys)

		redirect_to current_user, flash: {notice: "Thanks for answering the survey!"}
	end

	def update
		
	end
end
