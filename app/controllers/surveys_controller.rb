class SurveysController < ApplicationController


	def index
		#@surveys = Survey.all
	end


	def show
		@survey = Survey.find(params[:id])
		@questions = @survey.questions
		
		@prompts = Hash.new
		@questions.each do |q|
			@prompts = @prompts.merge({q.id => q.prompts})
		end
	end

	def create
		
	end

	def update
		
	end
end
