module SearchesHelper
	def add_value(value,value_to_add)
		rtn_val = value.nil? ? nil : value.dup
		if rtn_val.blank? 
			rtn_val = value_to_add
		elsif !rtn_val.include? value_to_add
			rtn_val = rtn_val + ',' + value_to_add
		else
			rtn_val.slice! ","+value_to_add
			rtn_val.slice! value_to_add+","
			rtn_val.slice! value_to_add
		end
		return rtn_val
	end

	def add_filter(filter,filter_to_add,vals)

			rtn_val = filter.nil? ? nil : filter.dup
			if rtn_val.blank? 
				rtn_val = filter_to_add
			elsif !rtn_val.include? filter_to_add
				rtn_val = rtn_val + ',' + filter_to_add
			end
			if vals.blank?
				rtn_val.slice! ","+filter_to_add
				rtn_val.slice! filter_to_add+","
				rtn_val.slice! filter_to_add
			end
			return rtn_val
	end

	def get_path_hash(input_hash,query,type)
		path_hash = Hash.new
		input_hash.each {|key, value| path_hash[key] = value if !value.empty?}
		path_hash[:q] = query 
		path_hash[:t] = type
		return path_hash
	end

end
