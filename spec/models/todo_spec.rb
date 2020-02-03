require 'rails_helper'

# Tes suite untuk model Todo
RSpec.describe Todo, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # Memastikan model Todo memiliki satu hubungan dengan model Item
  it { should have_many(:items).dependent(:destroy) }

  # Validasi
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
