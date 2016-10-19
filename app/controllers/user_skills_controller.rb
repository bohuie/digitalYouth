class UserSkillsController < ApplicationController

	# before_action :authenticate_user!, except: [:show] --to readd

	def new
		#@user_skill
	end

	def show
		#@user_skill = UserSkill.find(params[:id])
	end

	def edit
		#@user_skill = UserSkill.find(params[:id])
	end

	def create
		@skill = Skill.find_by(name: params[:user_skill][:name])
		if @skill.nil?
			@skill = Skill.create(name: params[:user_skill][:name])
		end
		@user_skill = current_user.user_skills.create(skill_id: @skill.id, question_id: params[:user_skill][:question_id])
		if @user_skill.save
			#session.delete(:skill_id)
			flash[:success] = "New skill added."
			redirect_to current_user
		else
			#session.delete(:skill_id)
			flash[:error] = "There was a problem adding your skill.  Please try again later or contact an administrator."
			redirect_to current_user
		end
	end
end
