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
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
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
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
	end

	def show
		@project = Project.find(params[:id])
		@user = @project.user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
	end

	def edit
		@project = Project.find(params[:id])
		@skills = @project.skills
		@surveys = Survey.get_title_map
		@user= @project.user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
	end

	def create
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
		@project = current_user.projects.build(project_params)
		@surveys = Survey.get_title_map

		if check_fields && @project.save && @project.process_skills(params[:project][:project_skills_attributes])
			Project.reindex if !Rails.env.test?

			redirect_to current_user, flash: {success: "Project Created!"}
		else
			skill = Skill.new
			@project.project_skills.build(skill: skill)
			@project_skills = params[:project]["project_skills_attributes"]
			if flash[:wanring].blank?
				flash.now[:warning] = "Oops, there was an issue in creating your project."
			end
			render 'new'
		end
	end

	def update
		@user = current_user
		if user_signed_in? && @user == current_user
			@user_buckets = user_bucket(4)
		end
		@project = Project.find(params[:id])
		@surveys = Survey.get_title_map
		
		if check_fields && @project.update_attributes(project_params) && @project.process_skills(params[:project][:project_skills_attributes])
			Project.reindex if !Rails.env.test?
			redirect_to current_user, flash: {success: "Project successfully updated!"}
		else
			skill = Skill.new
			@project_skill = ProjectSkill.new(skill: skill)
			@project_skills = params[:project]["project_skills_attributes"]
			if flash[:warning].blank?
				flash.now[:warning] = "Oops, there was an issue in editing your Project."
			end
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

	def check_fields
		args = params[:project]
		if args["project_skills_attributes"].nil?
			@project.errors.add(:project_skills, "must have at least one skill")
			flash.now[:warning] = "You must enter some skills associated with this project."
		elsif !args["project_skills_attributes"].nil?
			destroy = true
			missing = false
			args["project_skills_attributes"].each do |index, m|
				if m["_destroy"] == "false"
					destroy = false 
					if m["skill_attributes"]["name"].blank?
						missing = true 
						@project.errors[:skill][index.to_i] = {} unless @project.errors[:skill][index.to_i]
						@project.errors[:skill][index.to_i][:name] = "must have a name."
					end
					if m["survey_id"].blank?
						missing = true 
						@project.errors[:skill][index.to_i] = {} unless @project.errors[:skill][index.to_i]
						@project.errors[:skill][index.to_i][:survey_id] = "must select a skill category." 
					end
				end
			end
			if missing
				flash.now[:warning] = "You must enter all skill fields."
			end

			if destroy
				@project.errors.add(:project_skills, "must have at least one skill")
				flash.now[:warning] = "You must enter some skills associated with this job." 
			end
		end
		if !flash[:warning].blank?
			return false 
		else
			return true
		end
	end
end
