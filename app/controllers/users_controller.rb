class UsersController < ApplicationController
#before_action :authenticate_user!
	def show
		@user = User.find(params[:id])

		if @user.has_role? :employee
			@projects = @user.projects;
			@references = Reference.where(user_id: current_user.id, confirmed: true)
			@num_unconfirmed_references = Reference.where(user_id: current_user.id, confirmed: false).count

			if user_signed_in? && current_user.id == @user.id
				@project = current_user.projects.build
			end

			@user_skills = @user.user_skills
			
			logger.debug "skill info: #{@user_skills.inspect}"

		elsif @user.has_role? :employer
			@job_postings = @user.job_postings;
			if user_signed_in? && current_user.id == @user.id
				@job_posting = current_user.job_postings.build
			end
		end
	end
end
