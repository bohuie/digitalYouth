class ReferenceMailer < ApplicationMailer
	default from: ENV['EMAIL_USERNAME']

	def reference_email(reference_email, user)
		@user = user
		@reference_email = reference_email
		@host_string = ENV['HOST_NAME'] #just the domain name to be added into the message
		@url_string = new_reference_url(@reference_email.reference_url, :host => "Edgemap")

		mail(to: @reference_email.email, subject: "#{@user.first_name} #{@user.last_name} Wants a reference!")
	end

end
