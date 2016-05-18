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

def new
	@user = User.find(params[:id])
	@reference = Reference.new
end

def create
	@reference = Reference.create(reference_params)
		if @reference.save
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
