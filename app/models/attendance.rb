class Attendance < ActiveRecord::Base

	belongs_to :course
	belongs_to :student
	belongs_to :user
end
