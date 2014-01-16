class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :description
      t.string :teacher
      t.date :end_date

      t.timestamps
    end
  end
end
