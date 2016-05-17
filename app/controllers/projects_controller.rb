class ProjectsController < ApplicationController

	before_action :authenticate_user!, except: [:show]
	before_action :project_owner, only: [:edit, :update, :destroy]

	def new
		@jproject
	end

	def show
		@project = Project.find(params[:id])
	end

	def edit
		@project = Project.find(params[:id])
	end

	def create
		@project = current_user.projects.build(project_params)
		if @project.save
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

	def project_owner
		@project = Project.find(params[:id])
		
		unless @project.user_id == current_user.id
			flash[:notice] = 'Access denied as you are not owner of this Project'
			redirect_to current_user
		end
	end
end
