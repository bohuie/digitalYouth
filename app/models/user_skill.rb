class UserSkill < ActiveRecord::Base

	attr_accessor :name

	belongs_to :user
	belongs_to :skill
	belongs_to :question

	#validates :rating, presence: true, rating: true
	accepts_nested_attributes_for :skill, reject_if: lambda {|a| a[:name].blank?}

	def process_skills(hash) # Creates and Updates user skills, creating new skills when needed.
		byebug
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
				question_id = m[1]["question_id"]

				if id.blank?
					project_skill = ProjectSkill.new(skill_id: skill_id, question_id: question_id, project_id: self.id)
					return false if !project_skill.save
				else
					project_skill = ProjectSkill.find(id)
					return false if !project_skill.update(skill_id: skill_id, question_id: question_id, project_id: self.id)
				end
			end
		end
		return true
	end
end
