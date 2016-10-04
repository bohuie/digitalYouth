module JobPostingsHelper
	def link_to_add_job_posting_fields(name, f, css_class = "")
    	new_object = JobPostingSkill.new
    	new_object.skill = Skill.new
    	association = :job_posting_skills
    	fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      		render("/job_postings/" + association.to_s.singularize + "_fields", id: "new_#{association}", f: builder)
    	end
    	link_to name, '#job_skills', onclick: "add_job_posting_fields(\"#{association}\", \"#{escape_javascript(fields)}\")", class: css_class
  	end
end
