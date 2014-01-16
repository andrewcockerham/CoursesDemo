class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :student_id
      t.integer :course_id

      t.timestamps
    end
    add_index :registrations, :student_id
    add_index :registrations, :course_id
  end
end
