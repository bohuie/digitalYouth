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

	def self.get_table_data(user)
		surveys = Survey.all
		responses = user.responses
		survey_results = Hash.new
		if !responses.empty?
			responses.each do |r| #performs 12 queries
				survey_results[r.survey_id] = r.get_data_map
			end
		end
		return survey_results
	end

	def self.get_average_data
		surveys = Survey.all
		survey_results = Hash.new
		Response.where("user_id = -1").find_each do |r|
			survey_results[r.survey_id] = r.get_data_map
		end
		return survey_results
	end
end
