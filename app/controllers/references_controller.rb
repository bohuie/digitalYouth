class ReferencesController < ApplicationController

def show
	##preliminary code
	if @user.has_role? :employee
		@references = @user.references

		if user_signed_in? && current_user.id == @user.id
			##If user is signed in and the reference is theirs				
		end
end

def new
	@user = User.find(params[:id])
	@reference
end

def create
	@reference = @user.references.build(reference_params)
		if @reference.save
			redirect_to references_path
		else
			render references_path
		end
end

private
	def reference_params
		params.require(:reference).permit(:first_name, :last_name, :email, :company, :position, :phone_number, reference_body)
	end
end

end
