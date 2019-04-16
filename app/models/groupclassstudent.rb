class GroupclassStudent < ActiveRecord::Base
    belongs_to :groupclass 
    belongs_to :student
end