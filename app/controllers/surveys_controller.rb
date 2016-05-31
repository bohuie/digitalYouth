class SurveysController < ApplicationController
	include ConstantHelper

	before_action :authenticate_user!
	before_action :check_role

	def show
		# Fetch Survey data
		@survey = Survey.find_by(title: params[:title])
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
	def get_meanings(title)
		if title == "Time, Project, People" || title == "21st Century Skills"
			meanings = ["I don't do most of these","For some of these, I do them sometimes",
						"For some of these, I do them often","For most or all of these, I do them all the time"]
		else
			meanings = ["I dont know how to do any of these","For a few of these I can do them well",
						"For about half of these, I can do them well","For most or all of these, I can do them well"]
		end
		return meanings
	end

	def check_role
		if !current_user.has_role? :employee
			redirect_to current_user, flash: {warning: "You need to be an employee or a potential employee to perform a survey"}
		end
	end
end
