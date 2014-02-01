class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :student_id
      t.integer :course_id

      t.timestamps
    end
    add_index :attendances, :student_id
    add_index :attendances, :course_id
  end
end
