class AuthorizeApiRequest
	def initialize(headers = {})
		@headers = headers
	end

	# Service entry point, mengembalikan object user yang valid
	def call
		{
			user: user
		}
	end

	private

	attr_reader :headers

	def user
		# Cek apakah user ada di database
		# Memoize user object
		@user ||= User.find(decode_auth_token[:user_id]) if decode_auth_token

		# Menangani jika user tidak ditemukan
	rescue ActiveRecord::RecordNotFound => e
		# Raise custom error
		raise(ExceptionHandler::InvalidToken, ("#{Message.invalid_token} #{e.message}"))
	end

	# Decode authentication token
	def decode_auth_token
		@decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
	end

	# Cek untuk token di 'Authorization' header
	def http_auth_header
		if headers['Authorization'].present?
			return headers['Authorization'].split(' ').last
		end
		raise(ExceptionHandler::MissingToken, Message.missing_token)
	end
end