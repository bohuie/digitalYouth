class ProjectSkillsController < ApplicationController

	before_action :authenticate_user!
	before_action :project_owner, only: [:create, :update, :destroy]

	def create

		@skill = Skill.find_by(name: params[:project_skill][:name])
		params[:project_skill][:skill_id] = @skill.id
		@project_skill = ProjectSkill.new(project_skill_params)
		if @project_skill.save
			redirect_to edit_project_path(Project.find(params[:project_skill][:project_id]))
		else
			redirect_to current_user
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

	# Checks current user is the project owner.  Safety catch incase it makes it past project
	def project_owner
		@project = Project.find(params[:project_skill][:project_id])
		
		unless @project.user_id == current_user.id
			flash[:notice] = 'Access denied as you are not owner of this Project'
			@user = User.find(@project.user_id)
			redirect_to current_user
		end
	end
end
