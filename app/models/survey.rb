class Survey < ActiveRecord::Base
	has_many :questions
	accepts_nested_attributes_for :questions

	def format_title
		title_string = self.title
		# TODO: (Pseudo code)
		# If string contains digits
		# 	If string contains digits+st ||  digits+nd || digits+rd digits+th 
		# 		find the index following the digits
		# 		get substring following digits
		# 		make str = <sup> substring </sup>
		# 		insert  str into the string in place of digit suffix
		# 	end
		# end
		# return formatted title

		#in the mean time

		if title_string["21st Century Skills"]
			title_string = "21<sup>st</sup> Century Skills"
		end
		return title_string
	end
end
