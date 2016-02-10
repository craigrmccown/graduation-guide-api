# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create(model, data)
  if model.exists? data[:id]
    model.find data[:id]
  else
    model.create! data
  end
end

role_admin = create Role, id: 0, name: 'admin'
role_student = create Role, id: 1, name: 'student'
major_cs = create Major, id: 0, name: 'Computer Science', description: 'Georgia Tech computer science major'
major_ee = create Major, id: 1, name: 'Electrical Engineering', description: 'Georgia Tech electrical engineering major'
track_networks = create Track, id: 0, major_id: 0, name: 'Information Internetworks', description: 'Computer Science Information Internetworks thread'
track_sysarch = create Track, id: 1, major_id: 0, name: 'Systems & Architecture', description: 'Computer Science Systems and Architecture thread'
minor_biology = create Minor, id: 0, name: 'Biology', description: 'Georgia Tech Biology minor'
minor_music = create Minor, id: 1, name: 'Music', description: 'Georgia Tech Music minor'
course_cs1331 = create Course, id: 0, name: 'CS 1331', description: 'Object Oriented Programming'
course_cs1332 = create Course, id: 1, name: 'CS 1332', description: 'Data Structures and Algorithms'
course_cs3251 = create Course, id: 2, name: 'CS 3251', description: 'Networking I'
course_math3012 = create Course, id: 3, name: 'MATH 3012', description: 'Combinatorics'
course_cs3510 = create Course, id: 4, name: 'CS 3510', description: 'Design and Analysis of Algorithms'
course_cs4240 = create Course, id: 5, name: 'CS 4240', description: 'Compilers and Interpreters'
course_cs4210 = create Course, id: 6, name: 'CS 4210', description: 'Advanced Operating Systems'

major_cs.courses.destroy_all
track_networks.courses.destroy_all
track_sysarch.courses.destroy_all

major_cs.courses << course_cs1331
major_cs.courses << course_cs1332
major_cs.courses << course_math3012
track_networks.courses << course_cs3251
track_sysarch.courses << course_cs4240
track_sysarch.courses << course_cs4210

major_cs.save!
track_networks.save!
track_sysarch.save!
