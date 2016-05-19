class ReferenceMailer < ApplicationMailer
	default from: "digitalyouthtest@gmail.com"

	def reference_email(reference_email, user)
		@user = user
		@reference_email = reference_email
		@hoststring = "digitalYouth" ##just the domain name to be added into the message
		mail(to: @reference_email.email, subject: "#{@user.first_name} #{@user.last_name} Wants a reference!")
	end

end
