class JsonWebToken
	# Merahasiakan untuk encode dan decode token
	HMAC_SECRET = Rails.application.secrets.secret_key_base

	def self.encode(payload, exp = 24.hours.from_now)
		# Atur kedaluwarsa menjadi 24 jam dari waktu pembuatan
		payload[:exp] = exp.to_i

		# Sign token dengan application secret
		JWT.encode(payload, HMAC_SECRET)
	end

	def self.decode(token)
		# Mendapatkan payload. Index pertama dalam Array decoded
		body = JWT.decode(token, HMAC_SECRET)[0]
		HashWithIndifferentAccess.new body
		
		# Rescue dari semua error decode
	rescue JWT::DecodeError => e
		# Raise custom error untuk ditangani oleh custom handler
		raise ExceptionHandler::InvalidToken, e.message
	end
end