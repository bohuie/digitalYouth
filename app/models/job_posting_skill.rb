class JobPostingSkill < ActiveRecord::Base
	attr_accessor :name

	belongs_to :job_posting
	belongs_to :skill
end
