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
def resolve_prereqs(courses)
  f_zero = File.open('data/zero.txt', 'w')
  f_one = File.open('data/one.txt', 'w')
  f_two = File.open('data/two.txt', 'w')
  f_plus = File.open('data/plus.txt', 'w')

  begin
    courses.each do |course|
      grouch_data = JSON.parse course.grouch_data
      prereq_data = grouch_data['prerequisites']

      if prereq_data.nil?
        f_zero.puts "0: #{course.name}"
      elsif prereq_data['courses'].length == 1
        f_one.puts "1: #{course.name}, #{prereq_data}"
      elsif prereq_data['courses'].length == 2
        f_two.puts "2: #{course.name}, #{prereq_data}"
      else
        f_plus.puts "3+: #{course.name}, #{prereq_data}"
      end
    end
  ensure
    f_zero.close
    f_one.close
    f_two.close
    f_plus.close
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
courses = resolve_prereqs(Course.all)

# "prerequisites"=>{"courses"=> ["CS 4641", {"courses"=>["CS 4495", "CS 7495"], "type"=>"or"}]

