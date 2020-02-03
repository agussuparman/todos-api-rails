require 'rails_helper'

# Test suite untuk User model
RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # Memastikan model User memiliki satu hubungan dengan model Todo
  it { should have_many(:todos) }

  # Validasi
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
