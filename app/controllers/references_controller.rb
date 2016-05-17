class ReferencesController < ApplicationController

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
