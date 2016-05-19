class ReferencesController < ApplicationController

def show
	if user_signed_in?
		@confirmed_references = Reference.where(user_id: current_user.id, confirmed: true)
		@unconfirmed_references = Reference.where(user_id: current_user.id, confirmed: false)
	else
		redirect_to root_path
	end
end

def update
	@reference = Reference.find(params[:id])
	if user_signed_in? && @current_user.id==@reference.user_id 
		Reference.find(params[:id]).update(confirmed: !@reference.confirmed)

		if !@reference.confirmed
			redirect_to references_path, flash: {notice: "Reference confirmed!"}
		else
			redirect_to references_path, flash: {notice: "Reference Unconfirmed!"}
		end

	else
		redirect_to root_path
	end
end

def delete
	@reference = Reference.find(params[:id])
	if user_signed_in? && @current_user.id==@reference.user_id 
		Reference.find(params[:id]).destroy
		redirect_to references_path, flash: {notice: "Reference deleted!"}
	else
		redirect_to root_path
	end
end

def email
	if user_signed_in?
		url_string = ""
		loop do
			url_string = SecureRandom.urlsafe_base64(10)
			break if ReferenceRedirection.where(reference_url: url_string).empty?
		end
		@url = url_string
		@reference_email = ReferenceEmail.new
	else
		redirect_to root_path
	end
end

def sendMail
	if user_signed_in?
		@reference_email = ReferenceEmail.new(reference_email_params)
		params[:reference_email][:user_id] = current_user.id
		ReferenceRedirection.create(reference_email_params)

		ReferenceMailer.reference_email(@reference_email, current_user).deliver_now
		redirect_to references_path , flash: {notice: "Reference request sent!"}
	else
		redirect_to root_path
	end
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
	@reference = Reference.create(reference_params)
		if @reference.save
			url_string = request.referrer.rpartition('/')[-1] ##this is a really nasty way retrieving the random url, probably should fix this.
			ReferenceRedirection.find_by(reference_url: url_string).destroy
			redirect_to root_path , flash: {notice: "Thank you for making a reference!"} ##these flashes still need a place to display on the root page
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
end
