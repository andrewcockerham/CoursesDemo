class AddTeacherEmailToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :teacher_email, :string
  end
end
