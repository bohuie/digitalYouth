class Project < ActiveRecord::Base

	belongs_to :user

	has_many :project_skills, dependent: :destroy
	has_many :skills, through: :project_skills

	has_attached_file :image
	include DeletableAttachment

	validates :title, presence: true
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

	validates :user, presence: true
end
