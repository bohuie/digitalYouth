module SearchesHelper
	def add_condition(value,value_to_add)
		rtn_val = value.dup
		if rtn_val.blank? 
			rtn_val = value_to_add
		elsif !rtn_val.include? value_to_add
			rtn_val = rtn_val + ',' + value_to_add
		else
			rtn_val.slice! ","+value_to_add
			rtn_val.slice!  value_to_add
			rtn_val = rtn_val
		end
		return rtn_val
	end
end
