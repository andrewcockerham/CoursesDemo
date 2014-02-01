class Course < ActiveRecord::Base

	# Associations
	has_many :attendances
	has_many :students, through: :attendances
	has_many :users, through: :attendances

	has_attached_file :pdf
end
