class Response < ActiveRecord::Base
	belongs_to :user
	# The connection between a response and the questions is in the question_ids
	# scores[i] is a response to question_ids[i] question

	#Creates a Hashmap for chartkick to display {"classification" => score}
	def get_data_map
		length = self.scores.size
		rtn = Hash.new
		questions = Question.where(survey_id: self.survey_id)
		
		i = 0
		questions.each do |q|
			if question_ids[i] == q.id
				title = q.classification
			else
				title = Question.find(question_ids[i]).classification
			end
			score = self.scores[i]
			rtn[title] = score + 1 #this is +1 so the chart displays something
			i = i + 1
		end
		return rtn
	end

end
