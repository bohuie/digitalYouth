class SurveysController < ApplicationController

	before_action :authenticate_user!

	def show
		#Builds variables for the Survey page to display all information correctly
		@survey = Survey.find(params[:id])
		@questions = @survey.questions
		@update = false

		#update being facilitated in the same page
		if Response.find_by(user_id: current_user.id, survey_id: params[:id])
			@update = true
		end
		
		@prompts = Hash.new
		@questions.each do |q|
			@prompts = @prompts.merge({q.id => q.prompts})
			if @update
				#need to load the responses data somehow
			else
				q.responses.build #This is causing horrible issues where multiples of the radio buttons are built
			end
		end
	end

	def create
		#Fetch the responses to each question
		@responses = params[:survey][:questions_attributes]
		@survey_id = Integer(params[:survey][:id])
		@user = current_user

		#For each response add it to the database
		@responses.each do |r| 
			r = r.last
			@response = Response.create(score: r[:responses_attributes][:"0"][:score], user_id: @user.id, question_id: r[:id], survey_id: @survey_id)
		end
		
		#Record that the user has answered the survey
		@user.answered_surveys[@survey_id - 1] = true
		User.find(@user.id).update(answered_surveys: @user.answered_surveys)

		redirect_to current_user, flash: {notice: "Thanks for answering the survey!"}
	end

	def update
		
	end
end
