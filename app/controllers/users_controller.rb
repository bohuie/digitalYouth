class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])

		if @user.has_role? :employee
			@projects = @user.projects;
			@project = current_user.projects.build

		elsif @user.has_role? :employer
			@job_postings = @user.job_postings;
			@job_posting = current_user.job_postings.build
		end
	end
end
