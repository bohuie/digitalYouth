module SearchesHelper
	
	def active_search(link,type) # Returns the class string if the two input strings match
		if type.blank? && link == 'All'
			return "active-search"
		else
			return "active-search" if link == type
		end
	end

	def all_path_hash(input_hash,query,type,filters,filter,key) # Returns a path hash for searching on an all link
		path_hash = Hash.new
		input_hash.each {|key, value| path_hash[key] = value if !value.blank?}
		path_hash[:q] = query
		path_hash[:t] = type
		path_hash[:f] = remove_val(filter,filters)
		path_hash.delete(key)
		return path_hash
	end

	def get_path_hash(input_hash,query,type,filters,filter) # Returns a path hash for searching with filters
		path_hash = Hash.new
		input_hash.each {|key, value| path_hash[key] = value if !value.blank?}
		path_hash[:q] = query
		path_hash[:t] = type
		path_hash[:f] = set_or_append(filter,filters)
		return path_hash
	end

	def set_or_append(val,inpt_str) # Appends a string or returns 
		return nil if inpt_str.nil?
		rtn_val = inpt_str.dup
		if rtn_val.blank?
			rtn_val = val
		elsif !rtn_val.include? val
			rtn_val = rtn_val <<','<< val
		end
		return rtn_val
	end

	def remove_val(val,inpt_str) # Returns a string without the value specified
		return nil if inpt_str.nil?
		rtn_val = inpt_str.dup
		if rtn_val.include? val
			if rtn_val.include?(','+val)
				rtn_val.slice!(','+val)
			elsif rtn_val.include?(val+',')
				rtn_val.slice!(val+',')
			elsif rtn_val.include?(val)
				rtn_val.slice!(val)
			end
		end
		return rtn_val
	end
end