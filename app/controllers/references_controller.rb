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
	else
		redirect_to root_path
	end
end

def delete
	@reference = Reference.find(params[:id])
	if user_signed_in? && @current_user.id==@reference.user_id 
		Reference.find(params[:id]).destroy
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
	@reference_email = ReferenceEmail.new(reference_email_params)
	ReferenceRedirection.create(user_id: current_user.id, reference_url: @reference_email.reference_url, first_name: @reference_email.first_name, last_name: @reference_email.last_name, email: @reference_email.email)
	
	ReferenceMailer.reference_email(@reference_email, current_user).deliver_now
	redirect_to references_path
end


def new
	@reference_link = ReferenceRedirection.where(reference_url: params[:id])
	if !@reference_link.empty?
		@reference_link = @reference_link.first
		@user = User.find(@reference_link.user_id)
		@reference = Reference.new
	else
		redirect_to root_path
	end
end

def create
	@reference = Reference.create(reference_params)
		if @reference.save
			url_string = request.referrer.rpartition('/')[-1] ##this is a really nasty way retrieving the random url, need to fix!
			ReferenceRedirection.find_by(reference_url: url_string).destroy
			redirect_to root_path ##temporary
		else
			render root_path ##temporary
		end
end

private
	def reference_params
		params.require(:reference).permit(:first_name, :last_name, :email, :company, :position, :phone_number, :reference_body, :user_id)
	end

	def reference_email_params
		params.require(:reference_email).permit(:first_name, :last_name, :email, :reference_url)
	end
end
