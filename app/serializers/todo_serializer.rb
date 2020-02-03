class TodoSerializer < ActiveModel::Serializer
	# Attributes yang perlu di serialized
	attributes :id, :title, :created_by, :created_at, :updated_at

	# Hubungan model
	has_many :items
end