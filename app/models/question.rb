class Question < ActiveRecord::Base
	belongs_to :survey
	has_many :prompts

	has_many :questionresponses
	has_many :responses, through: :questionresponses
	accepts_nested_attributes_for :questionresponses
end
