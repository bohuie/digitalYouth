# This file is for any methods required in creating objects
# this is in the case where some extra steps are involved while creating the object

# Create skill method finds or creates by the name
def create_skill(name)
	skl = Skill.find_or_create_by(name: name)
	if !skl.save
		puts "failed, name: " + name
		puts skl.valid?
		puts skl.errors.full_messages
	end
	return skl
end

def create_category(name)
	cat = JobCategory.find_or_create_by(name: name)
	if !cat.save
		puts "failed, name: " + name
		puts cat.valid?
		puts cat.errors.full_messages
	end
	return cat
end