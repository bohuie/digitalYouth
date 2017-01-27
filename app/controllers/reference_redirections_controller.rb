class ReferenceRedirectionsController < ApplicationController

	def destroy # Deletes a reference request
		request = ReferenceRedirection.find(params[:id])
		request.destroy
		redirect_to current_user, flash: {success: "Reference request removed."}
	end
end