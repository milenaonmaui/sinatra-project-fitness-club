class Instructor < ActiveRecord::Base
    has_secure_password
    has_many :groupclasses
    has_many :students, through: :groupclasses
    validates :name, presence: true
    validates :email, presence: true
end