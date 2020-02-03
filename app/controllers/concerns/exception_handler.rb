module ExceptionHandler
	extend ActiveSupport::Concern

	# Menetapkan custom error subclasses, rescue menangkap 'StandardErrors'
	class AuthenticationError < StandardError; end
	class MissingToken < StandardError; end
	class InvalidToken < StandardError; end

	included do
		# Menetapkan penanganan khusus
		rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
		rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
		rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
		rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

		rescue_from ActiveRecord::RecordNotFound do |e|
			json_response({ message: e.message }, :not_found)
		end

		# rescue_from ActiveRecord::RecordInvalid do |e|
		# 	json_response({ message: e.message }, :unprocessable_entity)
		# end
	end

	private

	# Respons JSON dengan pesan. Kode status 422: entitas yang tidak dapat diproses
	def four_twenty_two(e)
		json_response({ message: e.message }, :unprocessable_entity)
	end

	# Respons JSON dengan pesan. Kode status 401: Tidak sah
	def unauthorized_request(e)
		json_response({ message: e.message }, :unauthorized)
	end
end