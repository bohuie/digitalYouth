class ResponsesController < ApplicationController
	def create
		@user = current_user
		@survey_id = Integer(params[:response][:survey_id])
		@scores = params[:response][:scores]
		@question_ids = params[:response][:question_ids]

		# Remap scores and question_id Hashmaps in the params to arrays
		@scores_array = Array.new
		@question_ids_array = Array.new
		for i in 0..@scores.size-1 do
			@scores_array[i] = Integer(@scores["#{i}"])
			@question_ids_array[i] = Integer(@question_ids["#{i}"])
		end

		# Prevents users from entering duplicates when hitting back after creating a response
		if @user.answered_surveys[@survey_id - 1] == false
			Response.create(user_id: @user.id, survey_id: @survey_id, scores: @scores_array, question_ids: @question_ids_array)
		else
			Response.find_by(user_id: @user.id, survey_id: @survey_id).update(scores: @scores_array, question_ids: @question_ids_array)
		end
		
		#Record that the user has answered the survey
		@user.answered_surveys[@survey_id - 1] = true
		@user.save

		redirect_to current_user, flash: {notice: "Thanks for answering the survey!"}
	end

	def update
		@user = current_user
		@survey_id = Integer(params[:response][:survey_id])
		@scores = params[:response][:scores]
		@question_ids = params[:response][:question_ids]
		
		# Remap scores and question_id Hashmaps in the params to arrays
		@scores_array = Array.new
		@question_ids_array = Array.new
		for i in 0..@scores.size-1 do
			@scores_array[i] = Integer(@scores["#{i}"])
			@question_ids_array[i] = Integer(@question_ids["#{i}"])
		end

		# Update the record
		@response = Response.find_by(user_id: @user.id, survey_id: @survey_id)
		@response.update(scores: @scores_array, question_ids: @question_ids_array)

		redirect_to current_user, flash: {notice: "Thanks for answering the survey!"}
	end
end
