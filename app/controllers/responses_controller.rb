class ResponsesController < ApplicationController

	before_action :authenticate_user!

	def create
		@user = current_user
		@survey_id = Integer(params[:response][:survey_id])
		@scores = params[:response][:scores]
		@question_ids = params[:response][:question_ids]

		# Remap scores and question_id Hashmaps in the params to arrays
		arrays = hash_to_array(@scores,@question_ids)
		@scores = arrays[0]
		@question_ids = arrays[1]

		# Prevents users from entering duplicates when hitting back after creating a response
		if @user.answered_surveys[@survey_id - 1] == false
			Response.create(user_id: @user.id, survey_id: @survey_id, scores: @scores, question_ids: @question_ids)
		else
			Response.find_by(user_id: @user.id, survey_id: @survey_id).update(scores: @scores, question_ids: @question_ids)
		end
		
		#Record that the user has answered the survey
		@user.answered_surveys[@survey_id - 1] = true
		@user.save

		redirect_to current_user, flash: {success: "Thanks for answering the survey!"}
	end

	def update
		@user = current_user
		@survey_id = Integer(params[:response][:survey_id])
		@scores = params[:response][:scores]
		@question_ids = params[:response][:question_ids]
		
		# Remap scores and question_id Hashmaps in the params to arrays
		arrays = hash_to_array(@scores,@question_ids)
		@scores = arrays[0]
		@question_ids = arrays[1]

		# Update the record
		@response = Response.find_by(user_id: @user.id, survey_id: @survey_id)
		@response.update(scores: @scores, question_ids: @question_ids)

		redirect_to current_user, flash: {success: "Thanks for answering the survey!"}
	end

private
	def hash_to_array(scores,questions) # Remap Hashmaps to arrays
		scores_array = Array.new
		question_ids_array = Array.new
		for i in 0..scores.size-1 do
			scores_array[i] = Integer(scores["#{i}"])
			question_ids_array[i] = Integer(questions["#{i}"])
		end
		return scores_array, question_ids_array 
	end
end
