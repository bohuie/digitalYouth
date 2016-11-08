class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:show, :index]
	before_action :profile_owner, only: [:edit, :update, :destroy]

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])

		@surveys = Survey.get_title_map

		if @user.has_role? :employee
			@projects = @user.projects.order('project_date DESC')
			@references = Reference.where(user_id: @user.id, confirmed: true)
			
			@survey_results = Survey.get_table_data(@user)
			@average_results = Survey.get_average_data

			if !@projects.empty?
				@skills = Hash.new
				@projects.each do |p|
					@skills = @skills.merge({p.id => p.skills})
				end
			end

			
			if user_signed_in? && current_user.id == @user.id
				@job_posting_applications = JobPostingApplication.where(applicant_id:current_user.id, status:-1..Float::INFINITY).order(status: :desc).includes(:job_posting)
				@num_unconfirmed_references = Reference.where(user_id: current_user.id, confirmed: false).count
				@project = current_user.projects.build
				project_skills = @project.project_skills.build
				project_skills.skill = Skill.new
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
		
		if params.include?(:personal)
			@user.update_attributes(personal_params)
			flash[:success] = "Personal Info successfully updated."
		elsif params.include?(:email)
			if @user.valid_password?(params[:user][:email_password])
				@user.update_attributes(email_params)
				flash[:success] = "Email successfully updated. You will have to confirm your new email before we update to that email."
			else
				flash[:danger] = "Incorrect password."
				render 'edit' and return
			end
		elsif params.include?(:password)
			if @user.valid_password?(params[:user][:current_password])
				@user.update_attributes(password_params)
				sign_in :user, @user, bypass: true
				flash[:success] = "Password successfully updated."
			else
				flash[:danger] = "Incorrect password."
				render 'edit' and return
			end
		elsif params.include?(:media)
			@user.update_attributes(media_params)
			flash[:success] = "Social Media successfully updated."
		elsif params.include?(:image)
			@user.update_attributes(image_params)
			flash[:success] = "Profile Image updated."
		elsif params.include?(:bio)
			@user.update_attributes(bio_params)
			flash[:success] = "Bio updated."
		else
			flash[:danger] = "Something went wrong.  Please contact an administrator."
		end
		redirect_back_or user_path
	end

	def finish_signup
    	# authorize! :update, @user 
    	if request.patch? && params[:user] #&& params[:user][:email]
      		if @user.update(user_params)
        		@user.skip_reconfirmation!
        		sign_in(@user, :bypass => true)
        		redirect_to @user, notice: 'Your profile was successfully updated.'
      		else
        		@show_errors = true
      		end
    	end
  	end

	private
	def user_params
		@user = User.find(params[:id])
		if @user.has_role? :employee
			params.require(:user).permit(:email, :first_name, :last_name, :github, :linkedin, :twitter, :facebook, :street_address, :city, :province, :postal_code, :password, :password_confirmation, :current_password)
		elsif @user.has_role? :employer
			params.require(:user).permit(:email, :first_name, :last_name, :linkedin, :twitter, :facebook, :company_name, :street_address, :city, :province, :postal_code, :password, :password_confirmation, :current_password)
		else
		end
	end

	def personal_params
		params.require(:user).permit(:first_name, :last_name, :street_address, :city, :province, :postal_code, :image, :delete_image)
	end

	def email_params
		params.require(:user).permit(:email)
	end

	def password_params
		params.require(:user).permit(:password, :password_confirmation)
	end

	def media_params
		params.require(:user).permit(:github, :linkedin, :twitter, :facebook)
	end

	def image_params
		params.require(:user).permit(:image, :delete_image)
	end

	def bio_params
		params.require(:user).permit(:bio)
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
