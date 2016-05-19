class ProjectsController < ApplicationController

	before_action :authenticate_user!, except: [:show]
	before_action :project_owner, only: [:edit, :update, :delete]

	def new
		@project = Project.new
	end

	def show
		@project = Project.find(params[:id])
	end

	def edit
		@project = Project.find(params[:id])
		@skills = @project.skills
		@project_skill = @project.project_skills.create
	end

	def create
		@project = current_user.projects.build(project_params)
		if @project.save
			redirect_to current_user
		else
			redirect_to current_user
		end
	end

	def update
		byebug
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

	# Checks current user is the project owner
	def project_owner
		@project = Project.find(params[:id])
		
		unless @project.user_id == current_user.id
			flash[:notice] = 'Access denied as you are not owner of this Project'
			@user = User.find(@project.user_id)
			redirect_to @user
		end
	end
end
