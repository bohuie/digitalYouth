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
			rtn[title] = score
			i += 1
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

	# Computes the average of all users for each survey
	def self.compute_averages
		surveys = Survey.uniq.pluck(:id)

		surveys.each do |survey|
			avg_data = Response.find_by(survey_id: survey, user_id: -1)
			count = 0
			sum = 0
			# Reset data to 0
			avg_data.scores.each_with_index do |data, index|
				avg_data.scores[index] = 0
			end
			Response.where("survey_id = ? AND user_id > 0 AND job_posting_id IS NULL", survey).find_each do |user|
				user.scores.each_with_index do |score, index|
					avg_data.scores[index] = avg_data.scores[index] + score
				end
				count += 1
			end

			if count != 0 
				avg_data.scores.each_with_index do |score, index|
					avg_data.scores[index] = avg_data.scores[index]/count
				end
			end
			avg_data.save
		end
	end
end
