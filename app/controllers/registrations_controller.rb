class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
  	if verify_recaptcha(model: User.new)
    	super
    else
    	flash[:warning] = "Please redo the Captcha"
		redirect_back_or "/users/sign_up"
    end
  end

  def update
    super
  end
end 