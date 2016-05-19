class ReferenceMailer < ApplicationMailer
	default from: "Reference@localhost:3000"

	def reference_email(reference_email, user)
		@user = user
		@reference_email = reference_email
		@hoststring = "digitalYouth"
		mail(to: @reference_email.email, subject: '#{@user.first_name} #{@user.last_name} Wants a reference!')
	end

end
