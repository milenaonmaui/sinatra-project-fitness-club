class Groupclass < ActiveRecord::Base
    belongs_to :instructor
    has_many :groupclass_students
    has_many :students, through: :groupclass_students

    def spots_available
       self.max_students - self.students.size
    end
end