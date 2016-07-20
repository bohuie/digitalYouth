class JobPosting < ActiveRecord::Base

	has_attached_file :company_logo
	include DeletableAttachment
	#validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

	has_many :job_posting_skills, dependent: :destroy
	has_many :skills, through: :job_posting_skills
	belongs_to :job_category

	accepts_nested_attributes_for :job_posting_skills, reject_if: lambda {|a| a[:question_id].blank?}, allow_destroy: true
	belongs_to :user

	def process_skills(hash) # Creates and Updates job posting skills, creating new skills when needed.
		hash.each do |m|
			id = m[1]["id"]
			if m[1]["_destroy"] == "true"
				JobPostingSkill.find(id).destroy if !id.blank?
			elsif m[1]["_destroy"] == "false"
				skill_name = m[1]["skill_attributes"]["name"].downcase
				skill = Skill.find_by(name: skill_name)
				if skill.nil?
					skill = Skill.new(name: skill_name)
					return false if !skill.save
				end
				skill_id = skill.id
				question_id = m[1]["question_id"]
				importance = m[1]["importance"]

				if id.blank?
					job_posting_skill = JobPostingSkill.new(skill_id: skill_id, question_id: question_id, importance: importance, job_posting_id: self.id)
					return false if !job_posting_skill.save
				else
					job_posting_skill = JobPostingSkill.find(id)
					return false if !job_posting_skill.update(skill_id: skill_id, question_id: question_id, importance: importance, job_posting_id: self.id)
				end
			end
		end
		return true
	end

	def is_expired? # checks to see if a job posting is expired
		if !self.close_date.nil?
			return true if self.close_date < Date.today
		end
		return false
	end
end
