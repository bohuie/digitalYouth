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
		project_skills = @project.project_skills.build
		project_skills.skill = Skill.new
		@surveys = Survey.get_title_map
	end

	def show
		@project = Project.find(params[:id])
	end

	def edit
		@project = Project.find(params[:id])
		@skills = @project.skills
		@project_skills = ProjectSkill.where(project_id:params[:id]).order(:id)
		@surveys = Survey.get_title_map
	end

	def create
		byebug
		#@project = Project.new(project_params)
		@project = current_user.projects.build(project_params)
		if @project.save && @project.process_skills(params[:project][:project_skills_attributes]) && process_project_skills
			#current_user.projects << @project
			Project.reindex if !Rails.env.test?
			flash[:success] = "Project successfully created."

			redirect_back_or current_user
		else
			flash[:danger] = "Please fix the errors below."
			render 'projects/new'
		end
	end

	def update
		@project = Project.find(params[:id])
		@skills = @project.skills
		
		if @project.update_attributes(project_params) && @project.process_skills(params[:project][:project_skills_attributes])
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
			Project.reindex if !Rails.env.test?
			flash[:success] = "Project successfully deleted."
		else

		end
		redirect_to current_user
	end

	private
	def project_params
		params.require(:project).permit(:title, :description, :image, :delete_image, :project_date)
	end

	def project_skill_params
		params.require(:project_skill).permit(:skill_id, :project_id)
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

	def process_project_skills

		if params[:project][:project_skills_attributes].nil?
			return true
		else
			params[:project][:project_skills_attributes].each do |h|
				if h[1]["_destroy"] == "false"
					if h[1]["skill"].nil?
						skill_name = h[1]["skill_attributes"]["name"].downcase
					else
						skill_name = h[1]["skill"].downcase
					end
					skill = Skill.find_by(name: skill_name)	
					user_skill = current_user.user_skills.where(skill_id: skill.id)
					byebug
					if user_skill.empty?
						current_user.user_skills.create(skill_id: skill.id, survey_id: h[1]["survey_id"])
					end
				else
					return false
				end
			end
		end
		return true
	end
end
