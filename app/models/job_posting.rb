class JobPosting < ActiveRecord::Base
	searchkick text_middle: [:province, :city, :company_name, :title, :skills, :description], callbacks: :async

	attr_accessor :yearly_upper_pay_range
	attr_accessor :hourly_upper_pay_range

	has_many :job_posting_skills, dependent: :destroy
	has_many :skills, through: :job_posting_skills
	has_many :job_posting_applications, dependent: :destroy
	has_many :responses
	belongs_to :job_category
	belongs_to :user
	accepts_nested_attributes_for :job_posting_skills, reject_if: lambda {|a| a[:survey_id].blank?}, allow_destroy: true

	validates :title, presence: { message: 'cannot be empty' }, unless: "user_id==0"
	validates :city, presence: { message: 'must have a city' }, unless: "user_id==0"
	validates :province, presence: { message: 'must have a province' }, unless: "user_id==0"
	validates :description, presence: { message: 'cannot be empty' }, unless: "user_id==0"
	validates :open_date, presence: { message: 'cannot be empty' }, unless: "user_id==0"
	validates :close_date, presence: { message: 'cannot be empty' }, unless: "user_id==0"
	validates :job_category_id, presence: { message: 'cannot be empty' }, unless: "user_id==0"
	validates :job_type, presence: { message: 'cannot be empty' }, unless: "user_id==0"
	#validate  :validate_skills
	#validates :job_posting_skills, presence: { message: 'must have valid skills' }
	
	#validate :date_check
	validate :lower_pay, unless: "user_id==0"
	validate :pay_check, unless: "user_id==0"

	def search_data
		data = Hash.new
 		data[:title] = title.titleize
 		if self.user_id == 0
	  		data[:company_name] = company_name.titleize if company_name
	  	else
	  		data[:company_name] = self.user.company_name.titleize if self.user
	  	end
	  	data[:city] = city.titleize.strip
	  	data[:province] = province.upcase.strip
	  	data[:job_type] = job_type
	  	#data[:description] = description.titleize
	  	data[:industry] = job_category_id
	  	data[:created_at] = created_at
	  	data[:close_date] = close_date
	  	data[:skills] = self.skills.pluck(:name)
	  	data[:expired] = self.is_expired?
	  	return data
	end

	def process_skills(hash) # Creates and Updates job posting skills, creating new skills when needed.
		if hash.nil?
			return true
		else
			hash.each do |m|
				id = m[1]["id"]
				survey_id = m[1]["survey_id"]

				if m[1]["_destroy"] == "true"
					#If there is no blank id, attempt to find the skill through other means and delete if it exists
					if id.blank?
						#Two different methods of items being added to the hash
						if m[1]["skill"].nil?
							skill_name = m[1]["skill_attributes"]["name"].titleize
						else
							skill_name = m[1]["skill"].titleize
						end

						skill = Skill.find_by(name: skill_name)
						unless skill.nil? #dont add skill, since user is deleting it from the list
							job_posting_skill = self.job_posting_skills.find_by(skill_id: skill.id, survey_id: survey_id)
							unless job_posting_skill.nil?
								job_posting_skill.destroy
							end
						end
					else
						JobPostingSkill.find(id).destroy
					end
				elsif m[1]["_destroy"] == "false"
					#Fringe case for catching different method of passing the skill
					if m[1]["skill"].nil?
						skill_name = m[1]["skill_attributes"]["name"].titleize
					else
						skill_name = m[1]["skill"].titleize
					end

					skill = Skill.find_by(name: skill_name)
					#Create the skill if it is not found
					if skill.nil?
						skill = Skill.new(name: skill_name)
						return false if !skill.save
					end

					importance = m[1]["importance"]

					#Add the skill to job posting's skills
					if id.blank?
						job_posting_skill = self.job_posting_skills.new(skill_id: skill.id, survey_id: survey_id, importance: importance)
						return false if !job_posting_skill.save
					else
						job_posting_skill = JobPostingSkill.find(id)
						return false if !job_posting_skill.update(skill_id: skill.id, survey_id: survey_id, importance: importance, job_posting_id: self.id)
					end
				end
			end
			return true
		end
	end

	def is_expired? # checks to see if a job posting is expired
		if !self.close_date.nil?
			return true if self.close_date < Date.today
		end
		return false
	end

	def get_type_string # Returns a string representation of the job type
		return JOB_TYPES.key(self.job_type)
	end

	def date_check
		if self.close_date <= self.open_date
			errors.add(:close_date, "must come after open date.")
		end
	end

	def lower_pay
		unless self.lower_pay_range
			if self.pay_rate == "yearly"
				errors.add(:yearly_lower_pay_range, "must have a from amount.")
			else
				errors.add(:hourly_lower_pay_range, "must have a from amount.")
			end
		end
	end

	def pay_check
		if !self.lower_pay_range.blank? && !self.upper_pay_range.nil? && self.upper_pay_range < self.lower_pay_range
			if self.pay_rate == "yearly"
				errors.add(:yearly_upper_pay_range, "must be greater than the from amount.")
			else
				errors.add(:hourly_upper_pay_range, "must be greater than the from amount.")
			end
		end
	end

	def validate_skills
		errors.add(:job_posting_skills, "must have at least one skill") if self.job_posting_skills.size < 1
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
