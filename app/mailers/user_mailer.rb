class UserMailer < ApplicationMailer

	def contact_user(to, from, subject, body)

		@from = from
		@to = to
		@body = body
		@subject = subject

		mail(to: @to.email, subject: @subject)
	end

end
