class ProjectSkillsController < ApplicationController

	def create
		byebug
		@skill = Skill.find_by(name: params[:project_skill][:name])
		@project = Project.find(params[:project_skill][:project_id])
		@project_skill = @project.project_skills.create(skill_id: @skill.id)
		if @project_skill.save
			redirect_to current_user
		else
			render current_user
		end
	end

	def update
		@project = Project.find(params[:id])
		if @project.update_attributes(project_params)
			redirect_to current_user
		else
			render 'edit'
		end
	end

	private
	def project_params
		params.require(:project).permit(:title, :description, :image)
	end
end
