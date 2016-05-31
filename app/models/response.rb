class Response < ActiveRecord::Base
	belongs_to :user
	# The connection between a response and the questions is in the question_ids
	# scores[i] is a response to question_ids[i] question

	#Creates a Hashmap for chartkick to display {"classification" => score}
	def get_data_map
		length = self.scores.size
		rtn = Hash.new

		for i in 0..length-1 
			title = Question.find(self.question_ids[i]).classification
			score = self.scores[i]
			rtn[title] = score + 1 #this is +1 so the chart displays something
		end
		return rtn
	end

end
