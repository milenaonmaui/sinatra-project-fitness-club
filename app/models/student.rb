class Student < ActiveRecord::Base
    has_secure_password
    has_many :groupclass_students
    has_many :groupclasses, through: :groupclass_students
    validates :name, :email, :password, presence: true
    validates :email, uniqueness: true
end