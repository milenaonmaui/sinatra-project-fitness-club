class Creategroupclassstudents < ActiveRecord::Migration
  def change
    create_table :groupclass_students do |t|
      t.integer :groupclass_id
      t.integer :student_id
    end
  end
end
