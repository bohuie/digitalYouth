class ReferencesController < ApplicationController

	before_action :authenticate_user!, except: [:new, :create]
	before_action :reference_owner, only: [:update, :delete]
	before_action :check_fields, only: [:send_mail]

	def index
		@confirmed_references = Reference.where(user_id: current_user.id, confirmed: true)
		@unconfirmed_references = Reference.where(user_id: current_user.id, confirmed: false)
	end

	def show
		@reference = Reference.find(params[:id])
	end

	def update
		@reference = Reference.find(params[:id])
		Reference.find(params[:id]).update(confirmed: !@reference.confirmed)

		msg = "Reference Confirmed!"
		if @reference.confirmed
			msg = "Reference Unconfirmed!"
		end
		redirect_to references_path, flash: {info: msg}
	end

	def delete
		@reference = Reference.find(params[:id])
		Reference.find(params[:id]).destroy
		redirect_to references_path, flash: {info: "Reference deleted!"}
	end

	def email
		@url = ""
		loop do
			@url = SecureRandom.urlsafe_base64(10)
			break if ReferenceRedirection.where(reference_url: @url).empty?
		end
		@reference_email = ReferenceEmail.new 
	end

	def send_mail
		@reference_email = ReferenceEmail.new(reference_email_params)
		params[:reference_email][:user_id] = current_user.id
		ReferenceRedirection.create(reference_email_params)

		ReferenceMailer.reference_email(@reference_email, current_user).deliver_now
		redirect_to references_path , flash: {success: "Reference request sent!"}
	end


	def new
		@reference_link = ReferenceRedirection.where(reference_url: params[:id])
		if !@reference_link.empty?
			@reference_link = @reference_link.first
			@user = User.find(@reference_link.user_id)
			@reference = Reference.new
		else
			redirect_to root_path , flash: {danger: "Invalid reference link."}
		end
	end

	def create
		@reference = Reference.new(reference_params)
		if @reference.save
			@url_string = request.referer.rpartition('/')[-1] # Retrieves the random part of the url on the new page
			ReferenceRedirection.find_by(reference_url: @url_string).destroy # Removes the redirection url
			redirect_to root_path , flash: {success: "Thank you for making a reference!"}
		else
			redirect_to root_path , flash: {danger: "There was a problem in saving the reference!"}
		end
	end

	private
	def reference_params
		params.require(:reference).permit(:first_name, :last_name, :email, :company, :position, :phone_number, :reference_body, :user_id)
	end

	def reference_email_params
		params.require(:reference_email).permit(:first_name, :last_name, :email, :reference_url, :user_id)
	end

	def reference_owner
		unless Reference.find(params[:id]).user_id == current_user.id
			redirect_to current_user, flash: {danger: "Access denied as you are not owner of this Reference."}
		end
	end

	def check_fields
		args = params[:reference_email]
		if args[:first_name].blank? || args[:last_name].blank? || args[:email].blank?
			redirect_to email_reference_path, flash: {warning: "Missing required fields"}
		end
		if args[:email] !~ Devise::email_regexp
			redirect_to email_reference_path, flash: {warning: "Enter a valid email address"}
		end
	end
end
