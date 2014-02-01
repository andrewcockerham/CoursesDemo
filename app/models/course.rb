class Course < ActiveRecord::Base

	# Associations
	has_many :attendances
	has_many :students, through: :attendances
	has_many :users, through: :attendances
end
