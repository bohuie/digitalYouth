class SearchesController < ApplicationController
	def index
		@query = params[:query]
		@results = User.search(@query)
		
	end
end
