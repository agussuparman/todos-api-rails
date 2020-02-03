require 'rails_helper'

RSpec.describe AuthenticateUser do
	# Membuat test user
	let(:user) { create(:user) }

	# Subjek request yang valid
	subject(:valid_auth_obj) { described_class.new(user.email, user.password) }

	# Subjek request yang tidak valid
	subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

	# Test suite untuk AuthenticateUser#call
	describe '#call' do
		# Mengembalikan token ketika request valid
		context 'when valid credentials' do
			it 'returns an auth token' do
				token = valid_auth_obj.call
				expect(token).not_to be_nil
			end
		end

		# Raise Authentication Error ketia request tidak valid
		context 'when invalid credentials' do
			it 'raises an Authentication error' do
				expect { invalid_auth_obj.call }.to raise_error(ExceptionHandler::AuthenticationError, /Invalid credentials/)
			end
		end
	end
end