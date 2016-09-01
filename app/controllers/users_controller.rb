class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:show, :index]
	before_action :profile_owner, only: [:edit, :update, :destroy]

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])

		@questions = Question.get_label_map

		if @user.has_role? :employee
			@projects = @user.projects;
			@references = Reference.where(user_id: @user.id, confirmed: true)
			
			@survey_results = Survey.get_table_data(@user)

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

			@user_skills = @user.user_skills

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

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		
		if @user.update_attributes(user_params)
			flash[:success] = "User successfully updated."
			redirect_to current_user
		else
			flash.now[:danger] = "Please fix the errors below."
			render 'edit'
		end
	end

	private
	def user_params

		@user = User.find(params[:id])
		if @user.has_role? :employee
			params.require(:user).permit(:email, :first_name, :last_name, :github, :linkedin, :twitter, :facebook, :password, :password_confirmation, :current_password)
		elsif @user.has_role? :employer
			params.require(:user).permit(:email, :first_name, :last_name, :linkedin, :twitter, :facebook, :company_name, :company_address, :company_city, :company_province, :company_postal_code, :password, :password_confirmation, :current_password)
		else
		end
	end

	# Checks current user is the profile owner
	def profile_owner
		@user = User.find(params[:id])
		unless @user.id == current_user.id
			flash[:warning] = "You can only make changes to your own profile."
			redirect_back_or current_user
		end
	end
end
