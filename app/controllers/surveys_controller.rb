class SurveysController < ApplicationController

	before_action :authenticate_user!

	def index
		#@surveys = Survey.all
	end


	def show
		@survey = Survey.find(params[:id])
		@questions = @survey.questions
		
		@prompts = Hash.new
		@questions.each do |q|
			@prompts = @prompts.merge({q.id => q.prompts})
			q.responses.build #This is causing horrible issues where multiples of the radio buttons are built
		end
	end

	def create
		@responses = params[:survey][:questions_attributes]
		@user = current_user

		@responses.each do |r|
			r = r.last
			byebug #score is nil for some reason
			@response = Response.create(score: r[:responses_attributes][:score], user_id: @user.id, question_id: r[:id])
		end

		redirect_to current_user, flash: {notice: "Thanks for answering the survey!"}
	end

	def update
		
	end
end
