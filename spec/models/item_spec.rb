require 'rails_helper'

# Tes suite untuk model Item
RSpec.describe Item, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # Memastikan model Item milik model Todo
  it { should belong_to(:todo) }

  # Validasi
  it { should validate_presence_of(:name) }
end
