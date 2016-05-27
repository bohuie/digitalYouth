class SurveysController < ApplicationController

	before_action :authenticate_user!

	def show
		@survey = Survey.find_by(title: params[:title])
		@questions = @survey.questions

		#facilitates updating
		@response = Response.find_by(user_id: current_user.id, survey_id: @survey.id)
		#need to figure out why it shows up as Class
		if @response == nil
			@response = Response.new
		end

		#Map the prompts to the questions
		@prompts = Hash.new
		@questions.each do |q|
			@prompts = @prompts.merge({q.id => q.prompts})
		end

		#Generates a collection to remove labels
		@collection_array = Array.new()
		for i in 0..3 #need to change this to MAX RATING 
			@collection_array.push([i,''])
		end	

	end
end
