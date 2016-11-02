class SettingsController < ApplicationController
  def consent
  	@consent = current_user.consent
  end

  def privacy
  end
end
