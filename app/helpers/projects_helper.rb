module ProjectsHelper

	def link_to_add_project_skill_fields(name, f, css_class = "")
     	new_object = ProjectSkill.new
     	new_object.skill = Skill.new
     	association = :project_skills
    	fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
       		render("/projects/" + association.to_s.singularize + "_fields", id: "new_#{association}", f: builder)
     	end
     	link_to name, '#project_skills', onclick: "add_project_skill_fields(\"#{association}\", \"#{escape_javascript(fields)}\")", class: css_class
   	end
end
