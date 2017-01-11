class UserMailer < ApplicationMailer

	def contact_user(to, from, body)

		@from = from
		@to = to
		@body = body

		mail(to: @to.email, subject: "#{@from.company_name} would like to talk to #{@to.first_name} #{@to.last_name}.")
	end

end
