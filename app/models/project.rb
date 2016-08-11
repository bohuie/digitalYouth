class Project < ActiveRecord::Base
	searchkick callbacks: :async

	belongs_to :user

	has_many :project_skills, dependent: :destroy
	has_many :skills, through: :project_skills

	has_attached_file :image
	include DeletableAttachment

	validates :title, presence: true
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

	validates :user, presence: true

	def search_data
		data = Hash.new
	  	data[:title] = title
	  	data[:description] = title
	  	data[:user_id] = self.user_id
	  	data[:created_at] = created_at
	  	data[:skills] = self.skills.pluck(:name)
	  	return data
	end
end
