class JobPostingApplication < ActiveRecord::Base
	has_one :applicant, :class_name => "User"
	has_one :company, :class_name => "User"
	belongs_to :job_posting

	def get_status_string #Returns a string representation of the status
		case self.status 
			when -1
				return "Rejected"
			when 0
				return "Undetermined"
			when 1
				return "Considering"
			when 2
				return "Accepted"
		end
	end

	def get_bootstrap_status #Returns a bootstrap representation of the status
		case self.status 
			when -1
				return "danger"
			when 0
				return "primary"
			when 1
				return "info"
			when 2
				return "success"
		end
	end
end