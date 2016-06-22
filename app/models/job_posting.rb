class JobPosting < ActiveRecord::Base
	searchkick
	
	belongs_to :user
end
