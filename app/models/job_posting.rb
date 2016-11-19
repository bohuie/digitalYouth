class JobPosting < ActiveRecord::Base
	searchkick word_start: [:location, :company_name, :title, :skills, :description], callbacks: :async

	has_many :job_posting_skills, dependent: :destroy
	has_many :skills, through: :job_posting_skills
	has_many :job_posting_applications, dependent: :destroy
	belongs_to :job_category
	belongs_to :user
	accepts_nested_attributes_for :job_posting_skills, reject_if: lambda {|a| a[:survey_id].blank?}, allow_destroy: true

	@@job_types = {"Full Time"=>0,"Part Time"=>1,"Contract"=>2,"Casual"=>3,
			 "Summer Positions"=>4,"Graduate Year Recruitment Program"=>5,
			 "Field Placement/Work Practicum"=>6,"Internship"=>7,"Volunteer"=>8}
	@@pay_rates = {"Salary" => "salary", "Hourly" => "hourly"}

	@@provinces = {"AB" => "AB", "BC" => "BC", "MB" => "MB", "NB" => "NB", "NL" => "NL", "NS" => "NS", 
			"NT" => "NT", "NU" => "NU", "ON" => "ON", "PE" => "PE", "QC" => "QC", "SK" => "SK", "YT" =>"YT"}


	def search_data
		data = Hash.new
		if close_date >= Date.today
	  	data[:title] = title.downcase
	  	if self.user_id.nil?
	  		data[:company_name] = company_name.downcase
	  	else
	  		data[:company_name] = self.user.company_name.downcase
	  	end
	  	data[:city] = city.downcase
	  	data[:job_type] = job_type
	  	data[:description] = description.downcase
	  	data[:industry] = job_category_id
	  	data[:created_at] = created_at
	  	data[:close_date] = close_date
	  	data[:skills] = self.skills.pluck(:name)
	  	end
	  	return data
	end

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
				survey_id = m[1]["survey_id"]
				importance = m[1]["importance"]

				if id.blank?
					job_posting_skill = JobPostingSkill.new(skill_id: skill_id, survey_id: survey_id, importance: importance, job_posting_id: self.id)
					return false if !job_posting_skill.save
				else
					job_posting_skill = JobPostingSkill.find(id)
					return false if !job_posting_skill.update(skill_id: skill_id, survey_id: survey_id, importance: importance, job_posting_id: self.id)
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

	def get_type_string # Returns a string representation of the job type
		return @@job_types.key(self.job_type)
	end

	def self.get_types_collection
		return @@job_types
	end

	def self.get_pay_rates
		return @@pay_rates
	end

	def self.get_provinces
		return @@provinces
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

		classifications = Survey.get_title_map
		if !responses.empty? # Compare to Survey Response
			job_skills.each do |j|
				responses.each do |r|
					i = 0
					s = r.survey_id
					#r.survey_id.each do |s|
						if s == j.survey_id
							if r.scores[i] > 0
								response_skill_matches.push({skill: j.skill, rating: r.scores[i], importance: j.importance, classification: classifications.key(j.survey_id)})
							end
						end
						i+=1
					#end
				end
			end
		end
		return {user_skill_matches: user_skill_matches, response_skill_matches: response_skill_matches, project_skill_matches: project_skill_matches}
	end
end
