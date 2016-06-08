module ApplicationHelper

	def from_current_time(from_time)
		str = ""
		measurement = ""
		num = 0
		diff = TimeDifference.between(from_time, Time.now.utc).in_general
		if diff[:years] >= 1 || diff[:months] >= 1 || diff[:weeks] >= 1
			month = from_time.strftime("%B")
			day = from_time.str("%d")
			year = from_time.strftime("%Y") if diff[:years] >= 1
			time = from_time.strftime("%I:%M%p")
			return month + " " + day + " " + year + " " + time

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
			str = num.to_s + " " + measurement
		else
			str = num.to_s + " " + measurement + "s"
		end
		return str + " ago"
	end
end
