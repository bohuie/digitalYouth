class ConsentController < ApplicationController

	before_action :authenticate_user!, except: [:business_consent, :adult_consent, :create]
	before_action :consent_owner, only: [:update]

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
  		if params[:consent][:name].nil?
  			params[:consent][:answer] = 0
  		else
  			params[:consent][:answer] = 1
  		end
  		
  		@consent = Consent.new(consent_params)

  		if @consent.save
  			flash[:success] = "Thank you for consenting to the study."
  			redirect_to root_url
  		else
  			flash.now[:danger] = "Please fix the errors below."
  			redirct_back_or
  		end
  	end

  	def update
  		@consent = Consent.find(params[:id])
  		
  		if @consent.update_attributes(consent_params)
  			flash[:success] = "Thank you for updating your consent settings."
  			redirect_back_or consent_settings_path
  		else
  			flash.now[:danger] = "An error occured. Please contact an administrator."
  			redirect_back_or
  		end
  	end

  	private
  	def consent_params
  		params.require(:consent).permit(:user_id, :name, :date_signed, :answer)
  	end

  	def consent_owner
  		@consent = Consent.find(params[:id])
		unless @consent.user_id == current_user.id
			flash[:warning] = "You can only make changes to your consent."
			redirect_back_or current_user
		end
  	end
end
