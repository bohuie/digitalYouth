class JobPosting < ActiveRecord::Base

	has_attached_file :company_logo
	include DeletableAttachment
	
	#validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

	has_many :job_posting_skills, dependent: :destroy
	has_many :skills, through: :job_posting_skills
	belongs_to :user
end
