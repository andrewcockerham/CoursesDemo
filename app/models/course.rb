class Course < ActiveRecord::Base

	# Associations
	has_many :registrations
	has_many :students, through: :registrations
end
