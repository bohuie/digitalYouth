class ReferencesController < ApplicationController

def show
		@user = User.find(params[:id])

		if @user.has_role? :employee
			@references = @user.references;

			if user_signed_in? && current_user.id == @user.id
				##If user is signed in and the reference is the				
			end

	end
end



end
