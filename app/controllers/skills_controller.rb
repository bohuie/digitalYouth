class SkillsController < ApplicationController
	def autocomplete # Renders a JSON array of skill names for jquery autocomplete
		@skills = Skill.order(:name).where("name LIKE ?", "%#{params[:term]}%")
		@skills.each {|s| s.name.capitalize!}
	    respond_to do |format|
	      format.json {render json: @skills.map(&:name).to_json}
   		end
	end
end
