class UsersController < ApplicationController
respond_to :html, :json

	before_action :authenticate_user!, except: [:show, :index, :nav_tab] #ignore home_tab, only done when it is the current user and logged in
	before_action :profile_owner, only: [:edit, :update, :destroy]
	skip_before_action :verify_authenticity_token, only: [:nav_tab] #ignore home_tab, only done when it is the current user and logged in
	before_action :job_provider_only, only: [:contact, :send_mail]

	
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

			@confirmed_references = Reference.where(user_id: @user.id, confirmed: true)
			
			if user_signed_in? && current_user.id == @user.id
				@job_posting_applications = JobPostingApplication.where(applicant_id:current_user.id, status:-1..Float::INFINITY).order(status: :desc).includes(:job_posting)
				@num_unconfirmed_references = Reference.where(user_id: current_user.id, confirmed: false).count
				@project = current_user.projects.build
				project_skills = @project.project_skills.build
				project_skills.skill = Skill.new

				@unconfirmed_references = Reference.where(user_id: current_user.id, confirmed: false)
				@reference_requests = ReferenceRedirection.where(email: current_user.email)
			end

			@user_skills = @user.user_skills.order(:survey_id)

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
			if @user.update_attributes(personal_params)
				flash[:success] = "Personal Info successfully updated."
				unless params[:user][:image].blank?
					render action: 'crop' and return
				end
			else
				flash[:danger] = "Unable to update your info, please check all fields are completed properly."
				render 'edit' and return
			end
		elsif params.include?(:email)
			if @user.valid_password?(params[:user][:email_password])
				if User.exists?(email: params[:user][:new_email])
					flash[:danger] = "That email is already taken."
					render 'edit' and return
				else
					params[:user][:email] = params[:user][:new_email]
					if @user.update_attributes(email_params)
						flash[:success] = "Email successfully updated. You will have to confirm your new email before we update to that email."
					else
						flash[:danger] = "There was an error updating your email.  Please check all fields are completed properly."
						render 'edit' and return
					end
				end
			else
				flash[:danger] = "Incorrect password."
				render 'edit' and return
			end
		elsif params.include?(:password)
			if @user.valid_password?(params[:user][:current_password])
				if @user.update_attributes(password_params)
					sign_in :user, @user, bypass: true
					flash[:success] = "Password successfully updated."
				else
					flash[:danger] = "There was an error updating your password.  Please check all fields are completed properly."
					render 'edit' and return
				end
			else
				flash[:danger] = "Incorrect password."
				render 'edit' and return
			end
		elsif params.include?(:media)
			if @user.update_attributes(media_params)
				flash[:success] = "Social Media successfully updated."
			else
				flash[:danger] = "There was an error updating your social media links.  Please check all fields are completed properly."
				render 'edit' and return
			end
		elsif params.include?(:image)
			if @user.update_attributes(image_params)
				flash[:success] = "Profile Image updated."
			else
				flash[:danger] = "There was an error updating your profile picture.  Please check all fields are completed properly."
				render 'edit' and return
			end
		elsif params.include?(:bio)
			if @user.update_attributes(bio_params)
				flash[:success] = "Bio updated."
			else
				flash[:danger] = "There was an error updating your bio.  Please check all fields are completed properly."
				render 'edit' and return
			end
		elsif params.include?(:crop)
			if @user.update_attributes(crop_params)
				@user.reprocess_image
				flash[:success] = "Profile Image updated."
			else
				flash[:danger] = "There was an error cropping your photo.  Please try again or contact an administrator."
				render 'edit' and return
			end
		else
			flash[:danger] = "Something went wrong.  Please contact an administrator."
		end
		redirect_to edit_user_path
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

	def contact # Page for form to send an email
		@user = User.find(params[:id])
		@url = ""
		@reference_email = ReferenceEmail.new 
	end

  	def send_mail # Sends the email
		contact = User.find(params[:id])
		unless contact.nil?
			#create notification?
		end

		UserMailer.contact_user(contact, current_user, params[:contact][:subject], params[:contact][:body]).deliver_now
		redirect_to contact , flash: {success: "Contact request sent!"}
	end

  	def home_tab
  		session[:home_tab] = params[:home_tab]
  		
  		if params.key?(:redirect)
  			respond_to do |format|
  				format.js { render js: "window.location = '#{params[:redirect]}'" }
  			end
  		end
  	end

  	def nav_tab
  		session[:nav_tab] = params[:nav_tab]
 
  		if params.key?(:redirect)
  			respond_to do |format|
  				format.js { render js: "window.location = '#{params[:redirect]}'" }
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

	def crop_params
		params.require(:user).permit(:crop_x, :crop_y, :crop_w, :crop_h)
	end

	def personal_params
		params.require(:user).permit(:first_name, :last_name, :street_address, :city, :province, :postal_code, :image, :delete_image, :company_name, :summary, :gender, :birth_date, :show_name, :show_location, :show_picture, :resume, :job_title, :at_company, :show_job)
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

	def job_provider_only
		unless current_user.has_role? :employer
			flash[:warning] = "Sorry, we couldn't find that page."
			redirect_back_or
		end
	end
end
