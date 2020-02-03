module ControllerSpecHelper
	# Membuat token dari user id
	def token_generator(user_id)
		JsonWebToken.encode(user_id: user_id)
	end

	# Menghasilkan token kadaluarsa dari user id
	def expired_token_generator(user_id)
		JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
	end

	# Mengembalikan headers yang valid
	def valid_headers
		{
			"Authorization" => token_generator(user.id),
			"Content-Type" => "application/json"
		}
	end

	# Mengembalikan headers yang tidak valid
	def invalid_headers
		{
			"Authorization" => nil,
			"Content-Type" => "application/json"
		}
	end
end
