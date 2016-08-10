class ReferencesController < ApplicationController

	before_action :authenticate_user!, except: [:new, :create]
	before_action :reference_owner, only: [:update, :delete]
	before_action :check_email_fields, only: [:send_mail]

	def index # Shows a users unconfirmed, confirmed references and reference requests
		@confirmed_references = Reference.where(user_id: current_user.id, confirmed: true)
		@unconfirmed_references = Reference.where(user_id: current_user.id, confirmed: false)
		@reference_requests = ReferenceRedirection.where(email: current_user.email)
	end

	def show # Shows a specific reference
		@reference = Reference.find(params[:id])
	end

	def update # Confirms or Unconfirms a reference
		@reference.update(confirmed: !@reference.confirmed)
		msg = "Reference Confirmed!"
		if @reference.confirmed
			msg = "Reference Unconfirmed!"
		end
		redirect_to references_path, flash: {info: msg}
	end

	def delete # Deletes (destroys) a reference
		@reference.destroy
		redirect_to references_path, flash: {info: "Reference deleted!"}
	end

	def email # Page for form to send an email
		@url = ""
		loop do
			@url = SecureRandom.urlsafe_base64(10)
			break if ReferenceRedirection.where(reference_url: @url).empty?
		end
		@reference_email = ReferenceEmail.new 
	end

	def send_mail # Sends the email
		@reference_email = ReferenceEmail.new(reference_email_params)
		params[:reference_email][:user_id] = current_user.id
		ReferenceRedirection.create(reference_email_params)

		ReferenceMailer.reference_email(@reference_email, current_user).deliver_now
		redirect_to references_path , flash: {success: "Reference request sent!"}
	end


	def new # Form to create a new reference
		@reference_link = ReferenceRedirection.where(reference_url: params[:id])
		if !@reference_link.empty?
			@reference_link = @reference_link.first
			@user = User.find(@reference_link.user_id)
			@reference = Reference.new
		else
			redirect_to root_path , flash: {danger: "Invalid reference link."}
		end
	end

	def create # Post action which creates the reference
		@reference = Reference.new(reference_params)
		@reference.referee_id = current_user.id if user_signed_in?
		@verified = verify_recaptcha(model: @reference)
		if @verified && !@owner && @reference.save
			@url_string = request.referer.rpartition('/')[-1] # Retrieves the random part of the url on the new page
			ReferenceRedirection.find_by(reference_url: @url_string).destroy # Removes the redirection url
			redirect_to root_path , flash: {success: "Thank you for making a reference!"}
		else
			if !@verified
				flash[:warning] = "Please redo the Captcha"
			else
				flash[:warning] = "There was an issue in creating your reference."
			end 
			redirect_back_or new_reference_path(request.referer.rpartition('/')[-1]) 
		end
	end

private
	def reference_params # Restricts reference parameters
		params.require(:reference).permit(:first_name, :last_name, :email, :company, :position, :phone_number, :reference_body, :user_id)
	end

	def reference_email_params # Restricts reference email parameters
		params.require(:reference_email).permit(:first_name, :last_name, :email, :reference_url, :user_id)
	end

	def reference_owner # Checks if a user is the owner of a reference
		@reference = Reference.find(params[:id])
		if @reference.user_id != current_user.id
			flash[:danger] = 'Access denied as you are not owner of this Reference.'
			redirect_back_or current_user
		else
			return @reference
		end
	end

	def check_email_fields # Validate email parameters
		args = params[:reference_email]
		if args[:first_name].blank? || args[:last_name].blank? || args[:email].blank?
			flash[:warning] = "Missing required fields"
		elsif args[:email] !~ Devise::email_regexp
			flash[:warning] =  "Enter a valid email address"
		elsif current_user.email == args[:email]
			flash[:warning] =  "You cannot give yourself a reference"
		end
		redirect_back_or email_reference_path if !flash[:warning].blank?
	end

	def check_reference_fields # Validate reference parameters
		args = params[:reference]
		if args[:first_name].blank? || args[:last_name].blank?|| args[:company].blank? || args[:position].blank? || args[:reference_body].blank?  
			flash[:warning] = "Missing required fields"
		elsif args[:email] !~ Devise::email_regexp
			flash[:warning] = "Enter a valid email address"
		elsif user_signed_in? && params[:reference_email][:user_id] == current_user.id
			flash[:warning] = "You cannot reference yourself"
		end
		redirect_back_or new_reference_path(request.referer.rpartition('/')[-1]) if !flash[:warning].blank?
	end
end
