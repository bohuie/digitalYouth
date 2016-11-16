class UserSkill < ActiveRecord::Base

	attr_accessor :name

	belongs_to :user
	belongs_to :skill
	belongs_to :survey

	validates_uniqueness_of :user_id, scope: [:skill_id, :survey_id]

	#validates :rating, presence: true, rating: true
end
