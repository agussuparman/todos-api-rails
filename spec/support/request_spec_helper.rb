module RequestSpecHelper
	# Parse Respons JSON terhadap ruby ​​hash
	def json
		JSON.parse(response.body)
	end
end