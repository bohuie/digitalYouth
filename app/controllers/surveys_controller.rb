class SurveysController < ApplicationController

	before_action :authenticate_user!

	def show
		# Fetch Survey data
		@survey = Survey.find_by(title: params[:title])
		@questions = @survey.questions
		@question_count = @questions.count
		@method = "post"

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
		for i in 0..3 #need to change this to MAX RATING 
			@collection_array.push([i,''])
		end	
	
		# Load data if it exists
		@data = Response.find_by(user_id: current_user.id, survey_id: @survey.id)
		if @data != nil
			@method = "patch"
			@values_array = @data.scores
		end
	end
end
