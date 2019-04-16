class Student < ActiveRecord::Base
    has_secure_password
    has_many :groupclass_students
    has_many :groupclasses, through: :groupclass_students
    validates :name, presence: true
    validates :email, presence: true
end