class Student < ActiveRecord::Base

	# Associatoins
	has_many :registrations
	has_many :courses, through: :registrations
end
