class ProjectsController < ApplicationController

	before_action :authenticate_user!, except: [:show]
	before_action :project_owner, only: [:edit, :update, :destroy]


	def index
		if !params[:user].nil?
			@user = User.find(params[:user])
			@projects = @user.projects
		else
			@user = current_user
			@projects = current_user.projects
		end

		if user_signed_in? && current_user.id == @user.id
			@project = Project.new
		end
	end

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
		#@project = Project.new(project_params)
		@project = current_user.projects.build(project_params)
		if @project.save
			#current_user.projects << @project
			Project.reindex if !Rails.env.test?
			flash[:success] = "Project successfully created."
			redirect_back_or
		else
			flash[:danger] = "Please fix the errors below."
			render 'users/show'
		end
	end

	def update
		@project = Project.find(params[:id])
		@skills = @project.skills
		@project_skill = @project.project_skills.create
		
		if @project.update_attributes(project_params)
			Project.reindex if !Rails.env.test?
			flash[:success] = "Project successfully updated."
			redirect_to current_user
		else
			flash.now[:danger] = "Please fix the errors below."
			render 'edit'
		end
	end

	def destroy
		if Project.find(params[:id])
			Project.find(params[:id]).destroy
			flash[:success] = "Project successfully deleted."
		else

		end
		redirect_to current_user
	end

	private
	def project_params
		params.require(:project).permit(:title, :description, :image, :delete_image)
	end

	# Checks current user is the project owner
	def project_owner
		@project = Project.find(params[:id])
		unless @project.user_id == current_user.id
			flash[:warning] = "You can only make changes to your projects."
			@user = User.find(@project.user_id)
			redirect_back_or current_user
		end
	end
end
