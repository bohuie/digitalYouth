class Skill < ActiveRecord::Base
	belongs_to :question

	has_many :user_skills
	has_many :users, through: :user_skills

	has_many :job_posting_skills, dependent: :destroy
	has_many :job_postings, through: :job_posting_skills

	has_many :project_skills, dependent: :destroy
	has_many :projects, through: :project_skills

	validates :name, presence: true, uniqueness: true
end
