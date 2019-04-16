instructor_list = {
    "Lilian" => {
      :email => "lilly@yahoo.com",
      
    },
    "Mino" => {
        :email => "mino@yahoo.com",
       
   },
   "Gina" => {
        :email => "gina@yahoo.com",
        
    }
  }

instructor_list.each do |name, instr_hash|
  p = Instructor.new
  p.name = name
  instr_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.password = "hello"
  p.save
end

class_list = {
    "Vinyasa" => {
      :class_type => "yoga",
      :max_students => 20,
      :instructor_id => 4
      
    },
    "Morning Spin" => {
        :class_type => "spin",
        :max_students => 15,
        :instructor_id => 4
       
   },
   "Zumba101" => {
        :class_type => "dance",
        :max_students => 25,
        :instructor_id => 5
    }
  }

class_list.each do |name, class_hash|
  p = Groupclass.new
  p.name = name
  class_hash.each do |attribute, value|
      p[attribute] = value
  end
 
  p.save
end

student_list = {
    "Darna" => {
      :email => "darna@yahoo.com",
      
    },
    "Sophia" => {
        :email => "sophia@yahoo.com",
       
   },
   "Violet" => {
        :email => "violet@yahoo.com",
        
    }
  }

student_list.each do |name, student_hash|
  p = Student.new
  p.name = name
  student_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.password = "hello"
  p.save
end