class AuthenticateUser
	def initialize(email, password)
		@email = email
		@password = password
	end

	# Service entry point
	def call
		JsonWebToken.encode(user_id: user.id) if user
	end

	private

	attr_reader :email, :password

	# Verifikasi user credentials
	def user
		user = User.find_by(email: email)
		return user if user && user.authenticate(password)
		# Memberikan Authentication error jika credentials tidak valid
		raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
	end
end