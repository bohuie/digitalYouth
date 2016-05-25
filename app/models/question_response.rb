class QuestionResponse < ActiveRecord::Base
	belongs_to :question
	belongs_to :response
	accepts_nested_attributes_for :response
end
