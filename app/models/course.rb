class Course < ActiveRecord::Base

	# Associations
	has_many :attendances
	has_many :students, through: :attendances
	has_many :users, through: :attendances

	has_attached_file :pdf

	validates_attachment_content_type :pdf, content_type: ['application/pdf']
																		#size: { less_than 10.megabytes }
end
