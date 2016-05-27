class SurveysController < ApplicationController

	before_action :authenticate_user!

	def show
		#Builds variables for the Survey page to display all information correctly
		@survey = Survey.find(params[:id])
		@questions = @survey.questions

		#facilitates updating
		@response = Response.find_by(user_id: current_user.id, survey_id: @survey.id)
		#need to figure out why it shows up as Class
		if @response == nil
			@response = Response.new
		end

		@prompts = Hash.new
		@questions.each do |q|
			@prompts = @prompts.merge({q.id => q.prompts})
		end
	end
end
