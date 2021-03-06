class Project < ActiveRecord::Base
	searchkick text_middle: [:title, :description, :owner_first, :owner_last, :skills], callbacks: :async

	belongs_to :user

	has_many :project_skills, dependent: :destroy
	accepts_nested_attributes_for :project_skills
	has_many :skills, through: :project_skills

	has_attached_file :image,
		default_url: 'default-project-:style.svg',
		styles: {
			medium: '200x200',
			thumb: "45x45#"
		}
	include DeletableAttachment

	validates :title, presence: true
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

	validates :user, presence: true

	def search_data
		data = Hash.new
	  	data[:title] = title.titleize
	  	data[:description] = description
	  	data[:owner_first] = self.user.first_name.titleize if self.user.show_name
	  	data[:owner_last] = self.user.last_name.titleize if self.user.show_name
	  	data[:created_at] = created_at
	  	data[:skills] = self.skills.pluck(:name)
	  	data[:project_date] = self.project_date
	  	return data
	end

	def process_skills(hash) # Creates and Updates project skills, creating new skills when needed.
		if hash.nil?
			return true
		else
			hash.each do |m|
				#Pull out common items and store into variable for easier reading
				id = m[1]["id"]
				survey_id = m[1]["survey_id"]

				#Delete the skill
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
							project_skill = self.project_skills.find_by(skill_id: skill.id, survey_id: survey_id)
							unless project_skill.nil?
								project_skill.destroy
							end
						end
					else
						ProjectSkill.find(id).destroy
					end

				#The skill is to be added
				elsif m[1]["_destroy"] == "false" || m[1]["_destroy"].empty?
					#Two different methods of items being added to the hash
					if m[1]["skill"].nil?
						skill_name = m[1]["skill_attributes"]["name"].titleize
					else
						skill_name = m[1]["skill"].titleize
					end
					#Create the skill if it is not found
					skill = Skill.find_by(name: skill_name)
					if skill.nil?
						skill = Skill.new(name: skill_name)
						return false if !skill.save
					end

					#Add it to the user's skills if they don't have it
					user_skill = UserSkill.find_by(user_id: self.user_id, skill_id: skill.id)
					if user_skill.nil?
						user_skill = UserSkill.new(user_id: self.user_id, skill_id: skill.id, survey_id: survey_id)
						return false if !user_skill.save
					end

					#Add the skill to project's skills
					if id.blank?
						project_skill = self.project_skills.new(skill_id: skill.id, survey_id: survey_id)
						return false if !project_skill.save
					else
						project_skill = ProjectSkill.find(id)
						return false if !project_skill.update(id: project_skill.id, skill_id: skill.id, survey_id: survey_id, project_id: self.id)
					end
				end
			end
			return true
		end
	end
end
