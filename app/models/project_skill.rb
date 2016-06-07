class ProjectSkill < ActiveRecord::Base

	attr_accessor :name
	#attr_accessor :project_id

	belongs_to :project
	belongs_to :skill
end
