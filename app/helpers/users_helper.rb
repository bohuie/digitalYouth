module UsersHelper

	def link_to_add_announcement_fields(name, f, css_class = "")
     	new_object = ResourceLink.new
     	association = :resource_links
    	fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
       		render("/users/announcement_fields", id: "new_#{association}", f: builder)
     	end
     	link_to name, 'javascript:;', onclick: "add_announcement_fields(\"#{association}\", \"#{escape_javascript(fields)}\")", class: css_class
   	end

   	def link_to_add_resource_link_fields(name, f, css_class = "")
     	new_object = ResourceLink.new
     	association = :resource_links
    	fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
       		render("/users/resource_link_fields", id: "new_#{association}", f: builder)
     	end
     	link_to name, 'javascript:;', onclick: "add_resource_link_fields(\"#{association}\", \"#{escape_javascript(fields)}\")", class: css_class
   	end
end
