class RatingValidator < ActiveModel::EachValidator

	include ConstantHelper
	def validate_each(record, attribute, value)
		unless value.to_s =~ /^\b[0-#{ max_rating }]\b$/i
			record.errors[attribute] << (options[:message] || "Skill rating must be between 0 and "+max_rating.to_s)
		end
	end
end