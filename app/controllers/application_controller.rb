class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
  	current_user
  end

  protected
	def configure_permitted_parameters

  		if params[:role] == 'employee'
  			devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    			user_params.permit({ roles: [] }, :email, :first_name, :last_name, :github, :linkedin, :twitter, :facebook, :password, :password_confirmation, :current_password)
   			end
   		elsif params[:role] == 'employer' 
  			devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    			user_params.permit({ roles: [] }, :email, :first_name, :last_name, :linkedin, :twitter, :facebook, :company_name, :company_address, :company_city, :company_province, :company_postal_code, :password, :password_confirmation, :current_password)
   			end
   		else
   		end
   end
end
