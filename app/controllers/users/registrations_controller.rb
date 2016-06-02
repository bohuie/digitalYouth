class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create


    build_resource(sign_up_params)
    if params[:role] == 'employee'
      @user.add_role :employee
    elsif params[:role] =='employer'
      @user.add_role :employer
    else
    end
    
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    byebug
    if params[:role] == 'employee'
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit( { roles: [:employee]}, :email, :first_name, :last_name, :github, :linkedin, :twitter, :facebook, :password, :password_confirmation, :current_password)
    elsif params[:role] == 'employer'
      devise_parameter_sanitizer.permit(:sign_up, role: [:employee, :employer])
    else
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, role: [:employee, :employer])
  end
  private
  def user_params

    @user = User.find(params[:id])
    if @user.has_role? :employee
      params.require(:user).permit(:email, :first_name, :last_name, :github, :linkedin, :twitter, :facebook, :password, :password_confirmation, :current_password)
    elsif @user.has_role? :employer
      params.require(:user).permit(:email, :first_name, :last_name, :linkedin, :twitter, :facebook, :company_name, :company_address, :company_city, :company_province, :company_postal_code, :password, :password_confirmation, :current_password)
    else
    end
  end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
