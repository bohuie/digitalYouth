class SurveysController < ApplicationController
	include ConstantHelper

	before_action :authenticate_user!
	before_action :check_role
	
	def show
		# Fetch Survey data
		@survey = Survey.find_by(title: params[:title])
		raw_results = @survey.get_data(current_user)
		@survey_results = Hash.new
		@survey_results[0] = {'Basic', raw_results['Basic']}
		@survey_results[1] = {'Intermediate', raw_results['Intermediate']}
		@survey_results[2] = {'Advanced', raw_results['Advanced']}
		@survey_results[3] = {'Expert', raw_results['Expert']}
		byebug
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

private
	def check_role
		if !current_user.has_role? :employee
			redirect_to current_user, flash: {warning: "You need to be an employee or a potential employee to perform a survey"}
		end
	end
end
