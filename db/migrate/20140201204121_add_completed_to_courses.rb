class AddCompletedToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :complete, :boolean
  end
end
