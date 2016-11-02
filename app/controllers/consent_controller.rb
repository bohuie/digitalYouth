class ConsentController < ApplicationController
	def business_consent
		@user = User.find(params[:id])
		if @user.has_role? :employee
			redirect_to adult_consent_path @user.id
		else
    		@consent = @user.build_consent
    	end
  	end

  	def adult_consent
  		@user = User.find(params[:id])
  		if @user.has_role? :employer
  			redirect_to business_consent_path @user.id
  		else
  			@consent = @user.build_consent
  		end
  	end

  	def create
  		@consent = Consent.new(consent_params)

  		if @consent.save
  			flash[:success] = "Thank you for consenting to the study."
  			redirect_to root_url
  		else
  			flash.now[:danger] = "Please fix the errors below."
  			redirct_back_or
  		end
  	end

  	private
  	def consent_params
  		params.require(:consent).permit(:user_id, :name, :date_signed)
  	end
end
