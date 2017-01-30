class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]
before_filter :logged_in, only: [:create]
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
    if verify_recaptcha(model: User.new)
      ##Extra.  To remove once consent/study is done
      if consent_name_match
        resource.save
        yield resource if block_given?
        if resource.persisted?
          if resource.active_for_authentication?
            set_flash_message! :notice, :signed_up
            sign_up(resource_name, resource)
            respond_with resource, location: after_sign_up_path_for(resource)
          else
            ## Original
            set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}."
            ## Custom
            #flash[:success]= "An email has been sent for confirmation.  Please fill out the consent form below."
            ## End
            expire_data_after_sign_in!
            ## Original routing
            respond_with resource, location: after_inactive_sign_up_path_for(resource)
            ## Custom
            #if params[:role] == 'employee'
            #  redirect_to adult_consent_path id: @user.id
            #elsif params[:role] =='employer'
            #  redirect_to business_consent_path id: @user.id
            #else
            #end
            ## End
          end
        else
          flash[:warning] = "The name in the consent form must match the first and last name supplied."
          redirect_back_or
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        redirect_back_or
      end
    else
      flash[:warning] = "Please redo the Captcha"
      redirect_back_or 
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

  def consent_name_match
    if params[:user].key?(:consent_attributes)
      unless (params[:user][:first_name].titleize+ " " + params[:user][:last_name].titleize).eql? params[:user][:consent_attributes][:name].titleize 
        flash[:warning] = "The name in the consent form must match the first and last name supplied."
        return false 
      end
    end
    return true
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :first_name, :last_name, :company_name, :postal_code, :city, :province])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

  private
  def logged_in
    if user_signed_in?
      redirect_to current_user
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
