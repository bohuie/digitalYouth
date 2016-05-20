class SurveysController < ApplicationController
	@category_0 = "Basic"
	@category_1 = "Intermediate"
	@category_2 = "Advanced"
	@category_3 = "Expert"

	def show
		#Show list of surveys and a link to each?
	end

	def create
		#Creates the survey response data items from the various form responses
		#aggregates the responses into their categories and creates the SurveyAnalysis entry
	end

	def update
		#similar to create but updates the form responses and analysis entry
	end
	
	def general
		#general form survey form
	end

	def networking
		#internet and networks survey form
	end

	def programming
		#programming survey form
	end

	def word
		#word survey form
	end

	def spreadsheet
		#speadsheet survey form
	end

	def collaboration
		#collaboration survey form
	end

	def project
		#project survey form
	end

	def money
		#money survey form
	end

	def presentation
		#presentation survey form
	end

	def multimedia
		#multimedia survey form
	end

	def social_media
		#social_media survey form
	end

	def modern_skills
		#modern_skills survey form
	end
end
