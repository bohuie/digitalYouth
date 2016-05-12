class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])

		if @user.has_role? :employer
			@job_postings = @user.job_postings;
		end
	end
end
