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
<<<<<<< HEAD
		@skill = Skill.find_by(name: params[:user_skill][:name])
		if @skill.nil?
			@skill = Skill.create(name: params[:user_skill][:name])
		end
		@user_skill = current_user.user_skills.create(skill_id: @skill.id, question_id: params[:user_skill][:question_id])
=======
		@skill = Skill.find_or_create_by(name: params[:user_skill][:name].downcase)
		@user_skill = current_user.user_skills.create(skill_id: @skill.id, survey_id: params[:user_skill][:survey_id])
>>>>>>> master
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
<<<<<<< HEAD
=======

	private
	def user_skill_params
		params.require(:user_skill).permit(:survey_id)
	end
>>>>>>> master
end
