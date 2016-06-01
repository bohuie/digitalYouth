class Response < ActiveRecord::Base
	belongs_to :user

	# The connection between a response and the questions is in the question_ids
	# scores[i] is a response to question_ids[i] question

	# Creates a Hashmap for chartkick to display {"classification" => score}
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

	# Remaps indexed Hashes of scores and questions to arrays
	def set_data_from_hash(scores,questions) 
		scores_array = Array.new
		question_ids_array = Array.new
		for i in 0..scores.size-1 do
			scores_array[i] = Integer(scores["#{i}"])
			question_ids_array[i] = Integer(questions["#{i}"])
		end
		self.scores = scores_array
		self.question_ids = question_ids_array
	end
end
