require "#{Rails.root}/lib/grouch"
require 'json'

# Inserts model if it doesn't already exist
def safe_create(model)
  if model.class.exists? model.id
    model.class.find model.id
  else
    model.save!
  end

  model
end

# Delete prerequisites recursively
def delete_prereqs(course)
  return if course.prereq_id.nil?

  query = "
    update courses
    set prereq_id = null
    where id = #{course.id};

    with recursive prereq_tree as (
      select id, parent_id
      from prereqs
      where id = #{course.prereq_id}
      union all
      select prereqs.id, prereqs.parent_id
      from prereqs
      join prereq_tree on
        prereqs.parent_id = prereq_tree.id
    ), delete_courses_prereqs as (
      delete from courses_prereqs
      where prereq_id in (
        select id from prereq_tree
      )
    )
    delete from prereqs
    where id in (
        select id from prereq_tree
    )
  "

  ActiveRecord::Base.connection.execute query
end

# Insert prerequisites recursively
def insert_prereqs(course, data, parent_id=nil)
  prereq = Prereq.new op: data['type'], parent_id: parent_id
  prereq.save!

  data['courses'].each do |prereq_course_data|
    if prereq_course_data.is_a?(String)
      begin
        course = Course.find_by! name: prereq_course_data
        prereq.courses << course
      rescue
        puts "Could not find course with name #{prereq_course_data}"
      end
    else
      insert_prereqs(course, prereq_course_data, prereq.id)
    end
  end

  prereq
end

# Clear output file
File.open('data/seeds.out', 'w').close

# Create static data
role_admin = safe_create Role.new(id: 0, name: 'admin')
role_student = safe_create Role.new(id: 1, name: 'student')
major_cs = safe_create Major.new(id: 0, name: 'Computer Science', description: 'Georgia Tech computer science major')

# Get grouch school ids
school_ids = Grouch::get_school_ids
grouch_course_ids = []

# Insert courses for each school
school_ids.each do |school_id|

  begin
    # Get courses in Grouch not yet in database
    grouch_course_ids = Grouch::get_course_ids school_id
    existing_course_ids = Course.all.collect { |course| course.id }
    new_course_ids = grouch_course_ids - existing_course_ids

    # Insert new courses
    new_course_ids.each do |course_id|
      begin
        data = Grouch::get_course school_id, course_id
      rescue Exception => e
        puts "#{e.message}, #{e.backtrace}"
      end

      course = Course.new id: course_id, name: data['identifier'], description: data['name'], grouch_data: data.to_json
      course.save!
    end
  rescue Exception => e
    puts "#{e.message}, #{e.backtrace}"
  end
end

# Index courses by name
courses_by_name = {}
Course.all.each { |course| courses_by_name[course.name] = course }

# Resolve prereqs
courses_by_name.each do |course_name, course|
  grouch_data = JSON.parse(course.grouch_data)
  next if grouch_data['prerequisites'].nil?
  prereq_data = grouch_data['prerequisites']

  delete_prereqs course
  root = insert_prereqs course, prereq_data
  course.prereq = root
  course.save!
end
