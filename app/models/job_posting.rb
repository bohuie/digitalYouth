class JobPosting < ActiveRecord::Base

	has_attached_file :company_logo
	include DeletableAttachment
	#validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

	has_many :job_posting_skills, dependent: :destroy
	has_many :skills, through: :job_posting_skills
	belongs_to :job_category

	accepts_nested_attributes_for :job_posting_skills, reject_if: lambda {|a| a[:question_id].blank?}, allow_destroy: true
	belongs_to :user
end
