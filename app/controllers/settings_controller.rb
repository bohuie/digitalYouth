class SettingsController < ApplicationController
	before_action :authenticate_user!
  def consent
  	@consent = current_user.consent
  end

  def privacy
  end
end
