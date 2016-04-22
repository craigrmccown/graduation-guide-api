require "#{Rails.root}/lib/grouch"
require 'json'

# Inserts model if it doesn't already exist
def safe_create(model)
  if model.class.exists? model.id
    model.class.find model.id
  else
    model.save!
  end
end

# Transforms grouch data into usable format
def transform_prereq(data)
  courses = data['courses']

  if courses.length == 1
    puts 'equals 1'
  elsif courses.length == 2
    puts 'equals 2'
  else
    puts 'over 2'
  end
end

# Create static data
role_admin = safe_create Role.new(id: 0, name: 'admin')
role_student = safe_create Role.new(id: 1, name: 'student')
major_cs = safe_create Major.new(id: 0, name: 'Computer Science', description: 'Georgia Tech computer science major')

# Get grouch course ids
major_id = 'CS'
grouch_course_ids = Grouch::get_course_ids major_id

# Get courses in Grouch not yet in database
existing_course_ids = Course.all.collect { |course| course.id }
new_course_ids = grouch_course_ids - existing_course_ids

# Insert new courses
new_course_ids.each do |course_id|
  data = Grouch::get_course major_id, course_id
  course = Course.new id: course_id, name: data['identifier'], description: data['name'], grouch_data: data.to_json
  major_cs.courses << course
end

# Resolve prereqs
courses = Course.all
courses.each do |course|
  course_data = JSON.parse course.grouch_data
  prereq_data = course_data['prerequisites']
  transform_prereq prereq_data unless prereq_data.nil?
end

# "prerequisites"=>{"courses"=> ["CS 4641", {"courses"=>["CS 4495", "CS 7495"], "type"=>"or"}]
