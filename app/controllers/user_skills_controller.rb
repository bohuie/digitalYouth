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
		#@user_skill = current_user.skills.build
	end

	private
	def user_skill_params
		params.require(:user_skill).permit(:rating)
	end
end
