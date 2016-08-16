module SearchesHelper

	def set_or_append(val_to_add,val) # Appends a string or returns 
		rtn_val = val.nil? ? nil : val.dup
		if rtn_val.blank?
			rtn_val = val_to_add
		elsif !rtn_val.include? val_to_add
			rtn_val = rtn_val <<','<< val_to_add
		end
		return rtn_val
	end

	def get_path_hash(input_hash,query,type,filters,filter) # Returns a path hash for searching with filters
		path_hash = Hash.new
		input_hash.each {|key, value| path_hash[key] = value if !value.blank?}
		path_hash[:q] = query
		path_hash[:t] = type
		path_hash[:f] = set_or_append(filter,filters)
		return path_hash
	end

	def all_path_hash(input_hash,query,type,filters,filter,key) # Returns a path hash for searching on an all link
		path_hash = Hash.new
		input_hash.each {|key, value| path_hash[key] = value if !value.blank?}
		path_hash[:q] = query
		path_hash[:t] = type
		path_hash[:f] = remove_val(filter,filters)
		path_hash.delete(key)
		byebug
		return path_hash
	end

	def active_search(link,type) # Returns the class string if the two input strings match
		return "active-search" if link == type
	end

	def remove_val(val,inpt_str) # Returns a string without the value specified
		if inpt_str.include? val
			if inpt_str.include? ','+val
				inpt_str.slice! ','+val
			elsif inpt_str.include? val+','
				inpt_str.slice! val+','
			elsif inpt_str.include? val
				inpt_str.slice!(val)
			end
		end
		return inpt_str
	end
	
end