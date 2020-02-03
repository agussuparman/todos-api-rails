class V2::TodosController < ApplicationController
	def index
		json_response({ message: 'Hello' })
	end
end