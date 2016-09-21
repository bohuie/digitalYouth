class Question < ActiveRecord::Base
	belongs_to :survey
	has_many :prompts

	has_many :responses
	accepts_nested_attributes_for :responses

	def self.get_label_map #Creates a hashmap of question_id => "Survey category: Survey title: Question classification"
		rtn = Hash.new
		questions = Question.all.includes(:survey)
		questions.each do |q|
			title = q.survey.category + ": " + q.survey.title + ": " + q.classification  
			rtn[title] = q.id
		end
		return rtn
	end

end
