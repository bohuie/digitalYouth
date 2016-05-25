class Response < ActiveRecord::Base
	belongs_to :user
	has_many :questionresponses
	has_many :questions, through: :questionresponses
end
