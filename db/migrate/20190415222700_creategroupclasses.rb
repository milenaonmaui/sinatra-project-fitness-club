class Creategroupclasses < ActiveRecord::Migration
  def change
    create_table :groupclasses do |t|
      t.string :name
      t.string :class_type
      t.integer :max_students
      t.integer :instructor_id
    end
  end
end
