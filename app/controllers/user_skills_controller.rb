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
		@skill = Skill.find_or_create_by(name: params[:user_skill][:name].downcase)
		@user_skill = current_user.user_skills.create(skill_id: @skill.id, survey_id: params[:user_skill][:survey_id])
		if @user_skill.save
			#session.delete(:skill_id)
			redirect_to current_user
		else
			#session.delete(:skill_id)
			redirect_to current_user
		end
	end

	private
	def user_skill_params
		params.require(:user_skill).permit(:survey_id)
	end
end
