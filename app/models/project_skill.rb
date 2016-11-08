class ProjectSkill < ActiveRecord::Base

	attr_accessor :name
	#attr_accessor :project_id

	belongs_to :project
	belongs_to :skill
	belongs_to :survey
	accepts_nested_attributes_for :skill, reject_if: lambda {|a| a[:name].blank?}
end
