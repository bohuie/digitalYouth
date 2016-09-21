class JobPostingSkill < ActiveRecord::Base
	attr_accessor :name

	belongs_to :question
	belongs_to :job_posting
	belongs_to :skill
	accepts_nested_attributes_for :skill, reject_if: lambda {|a| a[:name].blank?}
end
