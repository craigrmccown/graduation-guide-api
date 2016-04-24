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

# Create static data
role_admin = safe_create Role.new(id: 0, name: 'admin')
role_student = safe_create Role.new(id: 1, name: 'student')
major_cs = safe_create Major.new(name: 'Computer Science', description: 'Georgia Tech computer science major')
track_info_networks = safe_create Track.new(name: 'Information Internetworks', description: 'Represent, transform, transmit, and present data.')
track_systems_arch = safe_create Track.new(name: 'Systems & Architecture', description: 'Create computer architectures, systems, and languages.')
course_group_humanities = safe_create CourseGroup.new(name: 'Humanities')
course_group_lab_sciences = safe_create CourseGroup.new(name: 'Lab Sciences')
course_eng1101 = safe_create Course.new(name: 'ENG 1101', description: 'English I', hours: 3)
course_eng1102 = safe_create Course.new(name: 'ENG 1102', description: 'English II', hours: 3)
course_germ2001 = safe_create Course.new(name: 'GERM 2001', description: 'German I', hours: 3, course_group: course_group_humanities)
course_germ2002 = safe_create Course.new(name: 'GERM 2002', description: 'German II', hours: 3, course_group: course_group_humanities)
course_span2001 = safe_create Course.new(name: 'SPAN 2001', description: 'Spanish I', hours: 3, course_group: course_group_humanities)
course_span2002 = safe_create Course.new(name: 'SPAN 2002', description: 'Spanish II', hours: 3, course_group: course_group_humanities)
course_phys2211 = safe_create Course.new(name: 'PHYS 2211', description: 'Physics I', hours: 4, course_group: course_group_lab_sciences)
course_phys2212 = safe_create Course.new(name: 'PHYS 2212', description: 'Physics II', hours: 4, course_group: course_group_lab_sciences)
course_chem1310 = safe_create Course.new(name: 'CHEM 1310', description: 'General Chemistry', hours: 4, course_group: course_group_lab_sciences)
course_chem1211 = safe_create Course.new(name: 'CHEM 1211', description: 'Chemistry I', hours: 4, course_group: course_group_lab_sciences)
course_chem1212 = safe_create Course.new(name: 'CHEM 1212', description: 'Chemistry II', hours: 4, course_group: course_group_lab_sciences)
course_eas1600 = safe_create Course.new(name: 'EAS 1600', description: 'Earth and Atmospheric Sciences I', hours: 4, course_group: course_group_lab_sciences)
course_eas1601 = safe_create Course.new(name: 'EAS 1601', description: 'Earth and Atmospheric Sciences II', hours: 4, course_group: course_group_lab_sciences)
course_cs1301 = safe_create Course.new(name: 'CS 1301', description: 'Introduction to Computing and Programming', hours: 3)
course_cs1331 = safe_create Course.new(name: 'CS 1331', description: 'Introduction to Object-Oriented Programming', hours: 3)
course_cs1332 = safe_create Course.new(name: 'CS 1332', description: 'Data Structures and Algorithms', hours: 3)
course_cs2340 = safe_create Course.new(name: 'CS 2340', description: 'Objects and Design', hours: 3)
course_cs2110 = safe_create Course.new(name: 'CS 2110', description: 'Computing Organization and Programming', hours: 4)
course_cs2200 = safe_create Course.new(name: 'CS 2200', description: 'Computer Systems and Networks', hours: 4)

req_humanities = safe_create Requirement.new(major: major_cs, priority: 0, op: 'and')
rule_eng1101 = safe_create RequirementRule.new(requirement: req_humanities, rule_type: 'course', course: course_eng1101) 
rule_eng1102 = safe_create RequirementRule.new(requirement: req_humanities, rule_type: 'course', course: course_eng1102) 
rule_humanities_6hr = safe_create RequirementRule.new(requirement: req_humanities, rule_type: 'hours', quantity: 6, course_group: course_group_humanities)

req_phys2211 = safe_create Requirement.new(major: major_cs, priority: 1, op: 'and')
rule_phys2211 = safe_create RequirementRule.new(requirement: req_phys2211, rule_type: 'course', course: course_phys2211)

req_lab_sciences = safe_create Requirement.new(major: major_cs, priority: 2, op: 'or')
req_phys2212 = safe_create Requirement.new(parent_id: req_lab_sciences.id, priority: 0, op: 'and')
rule_phys2212 = safe_create RequirementRule.new(requirement: req_phys2212, rule_type: 'course', course: course_phys2212)
rule_lab_sciences_1course = safe_create RequirementRule.new(requirement: req_phys2212, rule_type: 'courses', quantity: 1, course_group: course_group_lab_sciences)
req_chem = safe_create Requirement.new(parent_id: req_lab_sciences.id, priority: 1, op: 'and')
rule_chem1211 = safe_create RequirementRule.new(requirement: req_chem, rule_type: 'course', course: course_chem1211)
rule_chem1212 = safe_create RequirementRule.new(requirement: req_chem, rule_type: 'course', course: course_chem1212)
req_eas = safe_create Requirement.new(parent_id: req_lab_sciences.id, priority: 2, op: 'and')
rule_eas1600 = safe_create RequirementRule.new(requirement: req_eas, rule_type: 'course', course: course_eas1600)
rule_eas1601 = safe_create RequirementRule.new(requirement: req_eas, rule_type: 'course', course: course_eas1601)
