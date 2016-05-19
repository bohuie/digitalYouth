class ProjectSkillsController < ApplicationController

	def create
		@skill = Skill.find_by(name: params[:project_skill][:name])
		params[:project_skill][:skill_id] = @skill.id
		@project = Project.find(params[:project_skill][:project_id])
		@project_skill = @project.project_skills.create(project_skill_params)
		if @project_skill.save
			redirect_to current_user
		else
			render current_user
		end
	end

	def update
		@project_skill = ProjectSkill.find(params[:id])
		if @project_skill.update_attributes(project_skill_params)
			redirect_to current_user
		else
			render 'edit'
		end
	end

	private
	def project_skill_params
		params.require(:project_skill).permit(:skill_id, :project_id)
	end
end
