require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
	# Authentication test suite
	describe 'POST /auth/login' do
		# Membuat test user
		let!(:user) { create(:user) }

		# Mengatur headers untuk authorization
		let(:headers) { valid_headers.except('Authorization') }

		# Mengatur credentials tes yang valid
		let(:valid_credentials) do
			{
				email: user.email,
				password: user.password
			}.to_json
		end
		
		# Mengatur credentials tes yang tidak valid
		let(:invalid_credentials) do
			{
				email: Faker::Internet.email,
				password: Faker::Internet.password
			}.to_json
		end

		# Mengatur request.headers ke custom headers
		# before { allow(request).to receive(:headers).and_return(headers) }

		# Mengembalikan auth token ketika request adalah valid
		context 'when request is valid' do
			before { post '/auth/login', params: valid_credentials, headers: headers }

			it 'returns an authentication token' do
				expect(json['auth_token']).not_to be_nil
			end
		end

		# Mengembalikan pesan kesalahan ketika request adalah tidak valid
		context 'when request is invalid' do
			before { post '/auth/login', params: invalid_credentials, headers: headers }

			it 'returns a failure message' do
				expect(json['message']).to match(/Invalid credentials/)
			end
		end
	end
end