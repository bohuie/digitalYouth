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
		# Distance function
		distance = 0
		user_skills = user.user_skills
		responses = user.responses
		job_skills = self.job_posting_skills.includes(:skill)
		user_skill_matches = Array.new
		response_skill_matches = Array.new

		# Compare to User Reported Skills
		if !user_skills.empty?
			job_skills.each do |j|
				match = false
				score = 0
				user_skills.each do |u|
					if u.skill_id == j.skill.id
						match = true
						score = u.rating
						user_skill_matches.push(u.skill)
					end
				end
				distance += compute_distance(match,j.importance,score) 
			end
		end

		# Compare to User Project Skills
		#if !project_skills.empty?
		#	job_skills.each do |j|
		#		user_skills.each do |u|
		#			if u == j.skill
		#				match = true
		#				score = u.rating
		#			end
		#		end
		#		distance = distance + compute_distance(match,j.importance,score) 
		#	end
		#end

		# Compare to Survey Response
		if !responses.empty?
			job_skills.each do |j|
				match = false
				score = 0
				responses.each do |r|
					i = 0
					r.question_ids.each do |q|
						if q == j.question_id
							match = true
							score = r.scores[i]
						end
						i+=1
					end
				end
				distance += compute_distance(match,j.importance,score) 
			end
		end
		byebug
		return {distance:distance, user_skill_matches: user_skill_matches, response_skill_matches: response_skill_matches}
	end

	# Raw distance above
	# Should also have ability to report:
	#  User has these skills in common with job posting
	#  User has completed these projectes which have skills in common with job posting
	#  User completed the survey which matches to the skills like this...

private
	def compute_distance(match,importance,score)
		dist = 0
		if match
			if importance == 2 #Required
				dist -= score
			else #Preferred
				dist -= score*0.5
			end
		else
			if importance == 2 #Required
				dist += 2
			else #Preferred
				dist += 1
			end
		end
		return dist
	end
end
