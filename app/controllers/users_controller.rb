class UsersController < ApplicationController
#before_action :authenticate_user!
	def show
		@user = User.find(params[:id])

		if @user.has_role? :employee
			@projects = @user.projects;
			@references = Reference.where(user_id: @user.id, confirmed: true)
			
			#Survey Results
			@survey_results = Response.joins(:question).select(:score, :classification, :survey_id).where(user_id: @user.id).pluck( :survey_id, :classification, :score)
			
			#byebug

			if !@projects.empty?
				@skills = Hash.new
				@projects.each do |p|
					@skills = @skills.merge({p.id => p.skills})
				end
			end

			
			if user_signed_in? && current_user.id == @user.id
				@num_unconfirmed_references = Reference.where(user_id: current_user.id, confirmed: false).count
				@project = current_user.projects.build
			end

			@user_skills = @user.user_skills #current user skills

			if user_signed_in? && current_user.id == @user.id
				@user_skill = current_user.user_skills.build
			end 

		elsif @user.has_role? :employer
			@job_postings = @user.job_postings;
			if user_signed_in? && current_user.id == @user.id
				@job_posting = current_user.job_postings.build
			end
		end
	end
end
