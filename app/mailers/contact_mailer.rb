class ContactMailer < ApplicationMailer
	default to: ENV['EMAIL_USERNAME']

	def lost_email (email, first_name, last_name, message)

		@contact_email = email
		@name = first_name + " " + last_name
		@message = message
		mail(from: email, subject: "Lost Username")
	end

	def contact_us (email, name, message)

		@contact_email = email
		@name = name
		@message = message
		mail(from: email, subject: @name + " would like to contact you.")
	end
end