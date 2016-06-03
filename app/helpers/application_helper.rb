module ApplicationHelper

	def from_current_time(from_time)
		str = ""
		measurement = ""
		num = 0
		diff = TimeDifference.between(from_time, Time.now).in_general
		if diff[:years] >= 1
			num = diff[:years]
			measurement = "year"
		elsif diff[:months] >= 1
			num = diff[:months]
			measurement = "month"
		elsif diff[:weeks] >= 1
			num = diff[:weeks]
			measurement = "week"
		elsif diff[:days] >= 1
			num = diff[:days]
			measurement = "day"
		elsif diff[:hours] >= 1
			num = diff[:hours]
			measurement = "hour"
		elsif diff[:minutes] >= 1
			num = diff[:minutes]
			measurement = "minute"
		elsif diff[:seconds] < 1
			return "just now"
		else
			num = diff[:seconds]
			measurement = "second"
		end

		if num == 1
			str = num + " " + measurement
		else
			str = num + " " + measurement + "s"
		end
		return str
	end
end
