class UserSkill < ActiveRecord::Base

	attr_accessor :name

	belongs_to :user
	belongs_to :skill

	validates :rating, presence: true, rating: true
end
