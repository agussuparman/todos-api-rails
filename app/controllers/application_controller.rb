class ApplicationController < ActionController::API
	include Response
	include ExceptionHandler

	# Dipanggil sebelum setiap action di controller
	before_action :authorize_request
	attr_reader :current_user

	private

	# Cek request token yang valid dan mengembailkan user
	def authorize_request
		@current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
	end
end