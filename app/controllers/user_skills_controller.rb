class UserSkillsController < ApplicationController

	before_action :authenticate_user!
	before_action :user_skill_owner, only: :destroy

	def new
		#@user_skill
	end

	def show
		#@user_skill = UserSkill.find(params[:id])
	end

	def edit
		#@user_skill = UserSkill.find(params[:id])
	end

	def edit_all
		@user = current_user
		@user_buckets = user_bucket(4)
		@user_skills = @user.user_skills.order(:survey_id)
	end

	def create
		@skill = Skill.find_or_create_by(name: params[:user_skill][:name].titleize)
		@user_skill = current_user.user_skills.create(skill_id: @skill.id, survey_id: params[:user_skill][:survey_id])
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

	def destroy
		user_skill = UserSkill.find(params[:id])
		if user_skill.delete
			flash[:success] = "That skill has been removed from your skill section."
			redirect_to edit_all_user_skill_path
		else
			flash[:warning] = 'There was an error deleting that skill.  Please try again later or contact an administrator.'
			redirect_to edit_all_user_skill_path
		end
	end

	private
	def user_skill_params
		params.require(:user_skill).permit(:survey_id)
	end

	def user_skill_owner
		user_skill = UserSkill.find(params[:id])
		if user_skill.blank?
			flash[:warning] = "There was an error with your skill update.  Please try again later or contact an administrator."
			redirect_to current_user
		end

		if user_skill.user != current_user
			flash[:warning] = "You may only delete your own skills."
			redirect_to current_user
		end
	end
end
