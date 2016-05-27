class ResponseController < ApplicationController

	def create
		@user = current_user
		@survey_id = Integer(params[:response][:survey_id])
		@scores = params[:response][:scores]
		@question_ids = params[:response][:question_ids]

		#For each response add it to the database
		#using .first_or_initialize because if the user presses back and then trys to resubmit it needs to update
		#also facilitates updating in a non-RESTful way
		@response = Response.where(user_id: @user.id, survey_id: @survey_id).first_or_initialize

		@scores_array = Array.new
		@question_ids_array = Array.new

		 for i in 0..@scores.size-1 do
			@scores_array[i] = Integer(@scores["#{i}"])
			@question_ids_array[i] = Integer(@question_ids["#{i}"])
		end

		@response.scores = @scores_array
		@response.question_ids = @question_ids_array
		@response.save
			
		#Record that the user has answered the survey
		@user.answered_surveys[@survey_id - 1] = true
		@user.save

		redirect_to current_user, flash: {notice: "Thanks for answering the survey!"}
	end

end
