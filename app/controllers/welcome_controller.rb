class WelcomeController < ApplicationController

  before_filter :logged_in, only: [:signup_jobseeker, :signup_employer]
  def index
    if user_signed_in? && current_user.has_role?(:employer)
      @new_application = PublicActivity::Activity.where(owner_id: current_user.id, is_read: false, key: "job_posting_application.create").take
      @expired_posting = JobPosting.where("user_id = ? AND close_date < ? ",current_user.id, Date.today).take
    end
    if user_signed_in?
      @user = current_user
      @user_buckets = user_bucket
    end
  end

  def about_us

  end

  def signup_jobseeker
    @job_seeker = User.new
    @job_seeker.build_consent
  end

  def signup_employer
    @employer = User.new
    @employer.build_consent
  end

  def contact_us

  end

  def send_contact_us
    if ContactMailer.contact_us(params[:user][:email], params[:user][:first_name], params[:user][:last_name], params[:user][:message]).deliver_now
      flash["notice"] = "Thank you for your message."
    else
      flash[:error] = "Your request couldn't be sent."
    end
    redirect_back_or root_path
  end

  def lost_email

  end

  def send_lost_email
  	if ContactMailer.lost_email(params[:user][:email], params[:user][:first_name], params[:user][:last_name], params[:user][:message]).deliver_now
  		flash["notice"] = "Thank you for your request.  An administrator will look into it and contact you."
  	else
  		flash[:error] = "Your request couldn't be sent."
  	end
  	redirect_back_or root_path
  end

  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  private
  def logged_in
    if user_signed_in?
      redirect_to root_path
    end
  end
end
