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
	Reference.find(params[:id]).update(confirmed: !@reference.confirmed)
end

def delete
	Reference.find(params[:id]).destroy
end

def email
	url_string = ""
	loop do
		url_string = SecureRandom.urlsafe_base64(10)
		break if ReferenceRedirection.where(reference_url: url_string).empty?
	end
	ReferenceRedirection.create(user_id: current_user.id, reference_url: url_string)
	@url = request.host + new_reference_path(url_string)
end

def new
	@reflink = ReferenceRedirection.where(reference_url: params[:id])
	if !@reflink.empty?
		@reflink = @reflink.first
		@user = User.find(@reflink.user_id)
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
end
