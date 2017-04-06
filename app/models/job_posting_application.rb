class JobPostingApplication < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :applicant, :class_name => "User"
	belongs_to :company, :class_name => "User"
	belongs_to :job_posting

	def self.get_status_int(status_str) #Returns an integer representation of the status
		# Undetermined is not included because it cannot be set.
		case status_str
			when "Rejected"
				return -1
			when "Considering"
				return 1
			when "Accepted"
				return 2
		end
	end

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

	def self.check_app(applicant, company)
		if applicant.has_role?(:employee) && company.has_role?(:employer) && JobPostingApplication.where('applicant_id = ? AND company_id = ? AND status > -1',applicant.id, company.id).take
			return true
		else
			return false
		end
	end
end