class JobPosting < ActiveRecord::Base

	has_attached_file :company_logo
	include DeletableAttachment
	
	#validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

	belongs_to :user
end
