class ReferencesController < ApplicationController

	before_action :authenticate_user!, except: [:new, :create]
	before_action :reference_owner, only: [:update, :delete]

	def index
		@confirmed_references = Reference.where(user_id: current_user.id, confirmed: true)
		@unconfirmed_references = Reference.where(user_id: current_user.id, confirmed: false)
	end

	def update
		@reference = Reference.find(params[:id])
		Reference.find(params[:id]).update(confirmed: !@reference.confirmed)

		msg = "Reference Confirmed!"
		if @reference.confirmed
			msg = "Reference Unconfirmed!"
		end
		redirect_to references_path, flash: {notice: msg}
	end

	def delete
		@reference = Reference.find(params[:id])
		Reference.find(params[:id]).destroy
		redirect_to references_path, flash: {notice: "Reference deleted!"}
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
		redirect_to references_path , flash: {notice: "Reference request sent!"}
	end


	def new
		@reference_link = ReferenceRedirection.where(reference_url: params[:id])
		if !@reference_link.empty?
			@reference_link = @reference_link.first
			@user = User.find(@reference_link.user_id)
			@reference = Reference.new
		else
			redirect_to root_path , flash: {notice: "Invalid reference link."}
		end
	end

	def create
		@reference = Reference.new(reference_params)
		if @reference.save
			@url_string = request.referer.rpartition('/')[-1] ##this is a really nasty way retrieving the random url, probably should fix this.
			ReferenceRedirection.find_by(reference_url: @url_string).destroy
			redirect_to root_path , flash: {notice: "Thank you for making a reference!"}
		else
			redirect_to root_path , flash: {notice: "Oops! there was a problem in saving the reference!"}
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
			redirect_to current_user, flash: {notice: "Access denied as you are not owner of this Reference."}
		end
	end
end
