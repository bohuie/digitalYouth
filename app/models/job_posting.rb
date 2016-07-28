class JobPosting < ActiveRecord::Base

	has_many :job_posting_skills, dependent: :destroy
	has_many :skills, through: :job_posting_skills
	has_many :job_posting_applications, dependent: :destroy
	belongs_to :job_category
	belongs_to :user
	accepts_nested_attributes_for :job_posting_skills, reject_if: lambda {|a| a[:question_id].blank?}, allow_destroy: true

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

	def compare_skills(user)
		user_skills = user.user_skills
		#project_skills = user.project_skills
		responses = user.responses
		job_skills = self.job_posting_skills.includes(:skill)
		user_skill_matches = Array.new
		response_skill_matches = Array.new
		project_skill_matches = Array.new
		
		if !user_skills.empty? # Compare to User Reported Skills
			job_skills.each do |j|
				user_skills.each do |u|
					user_skill_matches.push({user_skill: u, importance: j.importance}) if u.skill_id == j.skill.id
				end
			end
		end
		
		#if !project_skills.empty? # Compare to User Project Skills
		#	job_skills.each do |j|
		#		project_skills.each do |p|
		#			project_skill_matches.push(p) if p.skill_id == j.skill.id
		#		end
		#	end
		#end

		classifications = Question.get_label_map
		if !responses.empty? # Compare to Survey Response
			job_skills.each do |j|
				responses.each do |r|
					i = 0
					r.question_ids.each do |q|
						if q == j.question_id
							if r.scores[i] > 0
								response_skill_matches.push({skill: j.skill, rating: r.scores[i], importance: j.importance, classification: classifications.key(j.question_id)})
							end
						end
						i+=1
					end
				end
			end
		end
		return {user_skill_matches: user_skill_matches, response_skill_matches: response_skill_matches, project_skill_matches: project_skill_matches}
	end
end
