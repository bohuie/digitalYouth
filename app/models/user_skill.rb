class UserSkill < ActiveRecord::Base

	belongs_to :user
	belongs_to :skill

	validates :rating, presence: true, rating: true
end
