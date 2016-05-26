class UsersController < ApplicationController
#before_action :authenticate_user!
	def show
		@user = User.find(params[:id])

		if @user.has_role? :employee
			@projects = @user.projects;
			@references = Reference.where(user_id: @user.id, confirmed: true)
			
			#Survey Results
			#need to refactor this to use hashes not arrays
			@survey_rst = Response.joins(:question).select(:id, :survey_id, :classification, :score).where(user_id: @user.id).map(&:attributes)
			@survey_results = remap_survey(@survey_rst)
			

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

private
	def remap_survey(data)
		rtn = Array.new(12) {Hash.new}

		i = 0
		rtn.each do |sr|
			i = i + 1
			rtn[i - 1] = {:survey_id => i, "responses" => Hash.new}
		end
		
		data.each do |sr|
			rtn[sr["survey_id"] - 1]["responses"][sr["classification"]] = sr["score"]
		end
		return rtn
	end
end
