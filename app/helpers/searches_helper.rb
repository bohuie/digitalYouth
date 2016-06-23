module SearchesHelper
	def add_condition(value,value_to_add)
		rtn_val = value
		if value.blank? 
			rtn_val = value_to_add
		elsif !value.include? value_to_add
			rtn_val = value + ',' + value_to_add
		else
			value.slice! ","+value_to_add
			value.slice!  value_to_add
			rtn_val = value
		end
		return rtn_val
	end
end
