class SearchesController < ApplicationController
	def index
		@query = params[:query]
		@results = User.search(@query, index_name: [User.searchkick_index.name,Project.searchkick_index.name,JobPosting.searchkick_index.name], operator: "or")
	end
end
