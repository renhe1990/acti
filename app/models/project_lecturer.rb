class ProjectLecturer < ActiveRecord::Base
  acts_as_list

  belongs_to :course
  belongs_to :lecturer, class_name: 'User'
end
