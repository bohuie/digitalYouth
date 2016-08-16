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

	def add_filter(filters,filter_to_add)
			rtn_val = filters.nil? ? nil : filters.dup
			if rtn_val.blank? 
				rtn_val = filter_to_add
			elsif !rtn_val.include? filter_to_add
				rtn_val = rtn_val + ',' + filter_to_add
			end
			return rtn_val
	end

	def get_path_hash(input_hash,query,type,key=nil,all=false)
		path_hash = Hash.new
		input_hash.each {|key, value| path_hash[key] = value if !value.blank?}
		path_hash[:q] = query
		path_hash[:t] = type
		path_hash.delete(key) if !key.nil? && all
		return path_hash
	end

	def active_search(link,type)
		return "active-search" if link == type
	end
end
