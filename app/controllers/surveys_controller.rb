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
		@userid = current_user.id
		@cnt = 0
		@SQ_id = -1
		@response_value = -1

		# need to test this logic, dont know for sure that parameters are ordered and all
		loop for params do |p|
			if cnt%2 == 0
				@SQ_id = p
			else
				SurveyResponse.create(survey_question_id: @SQ_id, response: @response_value)
			end
		end
		#update users answered serveys (also make them in the user table)
	end

	def update
		#similar to create but updates the form responses and analysis entry
	end
	
	def general
		#general form survey form
		@general = GeneralSurveyResponse.new
	end

	def networking
		#internet and networks survey form
	end

	def programming
		#programming survey form
	end

	def word_processing
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

	private
		def aggregate()
			#category => [0,0,0,0]
			#if find(userid, surveyid)
			#sum up the data -- can be passed as an argument
			#update the entry
			#else 
			#sum up the data -- can be passed as an argument
			#create the entry

		end
end
