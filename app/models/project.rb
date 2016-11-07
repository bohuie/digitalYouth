class Project < ActiveRecord::Base
	searchkick word_start: [:title, :description, :owner_first, :owner_last, :skills], callbacks: :async

	belongs_to :user

	has_many :project_skills, dependent: :destroy
	accepts_nested_attributes_for :project_skills
	has_many :skills, through: :project_skills

	has_attached_file :image
	include DeletableAttachment

	validates :title, presence: true
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

	validates :user, presence: true

	def search_data
		data = Hash.new
	  	data[:title] = title.downcase
	  	data[:description] = description.downcase
	  	data[:user_id] = self.user_id #doesnt make sense?
	  	data[:owner_first] = self.user.first_name.downcase
	  	data[:owner_last] = self.user.last_name.downcase
	  	data[:created_at] = created_at
	  	data[:skills] = self.skills.pluck(:name)
	  	return data
	end

	def process_skills(hash) # Creates and Updates project skills, creating new skills when needed.
		hash.each do |m|
			id = m[1]["id"]
			if m[1]["_destroy"] == "true"
				ProjectSkill.find(id).destroy if !id.blank?
			elsif m[1]["_destroy"] == "false" || m[1]["_destroy"].empty?
				if m[1]["skill"].nil?
					skill_name = m[1]["skill_attributes"]["name"].downcase
				else
					skill_name = m[1]["skill"].downcase
				end
				skill = Skill.find_by(name: skill_name)
				if skill.nil?
					skill = Skill.new(name: skill_name)
					return false if !skill.save
				end
				skill_id = skill.id
				survey_id = m[1]["survey_id"]
				if id.blank?
					project_skill = ProjectSkill.new(skill_id: skill_id, survey_id: survey_id, project_id: self.id)
					return false if !project_skill.save
				else
					project_skill = ProjectSkill.find(id)
					return false if !project_skill.update(id: project_skill.id, skill_id: skill_id, survey_id: survey_id, project_id: self.id)
				end
			end
		end
		return true
	end
end
