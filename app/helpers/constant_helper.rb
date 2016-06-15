module ConstantHelper

	@max_rating

	def max_rating
		@max_rating = 3
	end

	def get_meanings(title)
		if title == "Time, Project, People" || title == "21st Century Skills"
			meanings = ["I don't do most of these","For some of these, I do them sometimes",
						"For some of these, I do them often","For most or all of these, I do them all the time"]
		else
			meanings = ["I dont know how to do any of these","For a few of these I can do them well",
						"For about half of these, I can do them well","For most or all of these, I can do them well"]
		end
		return meanings
	end
end