class Skill < ActiveRecord::Base
	
	has_many :user_skills, dependent: :destroy
	has_many :users, through: :user_skills

	has_many :job_posting_skills, dependent: :destroy
	has_many :job_postings, through: :job_posting_skills

	has_many :project_skills, dependent: :destroy
	has_many :projects, through: :project_skills

	validates :name, presence: true, uniqueness: true, case_sensitive: false

	before_save :format_name

	def format_name
		self.name.titleize
	end
end
