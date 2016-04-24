# Inserts model if it doesn't already exist
def safe_create(model)
  if model.class.exists? model.id
    model = model.class.find model.id
  else
    model.save!
  end

  model
end

# Roles
role_admin = safe_create Role.new(id: 0, name: 'admin')
role_student = safe_create Role.new(id: 1, name: 'student')

# Majors
major_ae = safe_create Major.new(id: 0, name: 'Aerospace Engineering', description: 'Georgia Tech aerospace engineering major')
major_ee = safe_create Major.new(id: 1, name: 'Electrical Engineering', description: 'Georgia Tech electrical engineering major')
major_ie = safe_create Major.new(id: 2, name: 'Industrial Engineering', description: 'Georgia Tech industrial engineering major')
major_me = safe_create Major.new(id: 3, name: 'Mechanical Engineering', description: 'Georgia Tech mechanical engineering major')
major_cs = safe_create Major.new(id: 4, name: 'Computer Science', description: 'Georgia Tech computer science major')
major_ba = safe_create Major.new(id: 5, name: 'Business Administration', description: 'Georgia Tech business administration major')

# Tracks
track_devices = safe_create Track.new(id: 0, major: major_cs, name: 'Devices', description: 'Create devices embedded in physical objects that interact in the physical world.')
track_info_networks = safe_create Track.new(id: 1, major: major_cs, name: 'Information Internetworks', description: 'Represent, transform, transmit, and present data.')
track_intelligence = safe_create Track.new(id: 2, major: major_cs, name: 'Intelligence', description: 'Build top-to-bottom models of rational agents and human-level intelligence.')
track_media = safe_create Track.new(id: 3, major: major_cs, name: 'Media', description: 'Build systems to exploit computing\'s abilities to provide creative outlets.')
track_modsim = safe_create Track.new(id: 4, major: major_cs, name: 'Modeling & Simulation', description: 'Represent natural and physical processes')
track_people = safe_create Track.new(id: 5, major: major_cs, name: 'People', description: 'Design, build, and evaluate systems that treat humans as the central component.')
track_systems_arch = safe_create Track.new(id: 6, major: major_cs, name: 'Systems & Architecture', description: 'Create computer architectures, systems, and languages.')
track_theory = safe_create Track.new(id: 7, major: major_cs, name: 'Theory', description: 'Discover the theoretical foundations underlying a wide range of computing disciplines.')

# Courses
course_group_humanities = safe_create CourseGroup.new(id: 0, name: 'Humanities')
course_group_lab_sciences = safe_create CourseGroup.new(id: 1, name: 'Lab Sciences')
course_group_info_management = safe_create CourseGroup.new(id: 2, name: 'Information Management')
course_eng1101 = safe_create Course.new(id: 0, name: 'ENG 1101', description: 'English I', hours: 3)
course_eng1102 = safe_create Course.new(id: 1, name: 'ENG 1102', description: 'English II', hours: 3)
course_germ2001 = safe_create Course.new(id: 2, name: 'GERM 2001', description: 'German I', hours: 3, course_groups: [course_group_humanities])
course_germ2002 = safe_create Course.new(id: 3, name: 'GERM 2002', description: 'German II', hours: 3, course_groups: [course_group_humanities])
course_span2001 = safe_create Course.new(id: 4, name: 'SPAN 2001', description: 'Spanish I', hours: 3, course_groups: [course_group_humanities])
course_span2002 = safe_create Course.new(id: 5, name: 'SPAN 2002', description: 'Spanish II', hours: 3, course_groups: [course_group_humanities])
course_math1551 = safe_create Course.new(id: 6, name: 'MATH 1551', description: 'Differential Calculus', hours: 3)
course_math1552 = safe_create Course.new(id: 7, name: 'MATH 1552', description: 'Integral Calculus', hours: 3)
course_math1554 = safe_create Course.new(id: 8, name: 'MATH 1554', description: 'Linear Algebra', hours: 3)
course_math2550 = safe_create Course.new(id: 9, name: 'MATH 2550', description: 'Intro to Multivariable Calculus', hours: 3)
course_math3012 = safe_create Course.new(id: 10, name: 'MATH 3012', description: 'Applied Combinatorics', hours: 3)
course_math3215 = safe_create Course.new(id: 11, name: 'MATH 3215', description: 'Intro to Probability and Statistics', hours: 3)
course_math3670 = safe_create Course.new(id: 12, name: 'MATH 3670', description: 'Probability and Statistics With Applications', hours: 3)
course_isye3770 = safe_create Course.new(id: 13, name: 'ISYE 3770', description: 'Statistics and Applications', hours: 3)
course_isye2027 = safe_create Course.new(id: 14, name: 'ISYE 2027', description: 'Probability With Applications', hours: 3)
course_isye2028 = safe_create Course.new(id: 15, name: 'ISYE 2028', description: 'Basic Statistical Methods', hours: 3)
course_phys2211 = safe_create Course.new(id: 16, name: 'PHYS 2211', description: 'Physics I', hours: 4, course_groups: [course_group_lab_sciences])
course_phys2212 = safe_create Course.new(id: 17, name: 'PHYS 2212', description: 'Physics II', hours: 4, course_groups: [course_group_lab_sciences])
course_chem1310 = safe_create Course.new(id: 18, name: 'CHEM 1310', description: 'General Chemistry', hours: 4, course_groups: [course_group_lab_sciences])
course_chem1211 = safe_create Course.new(id: 19, name: 'CHEM 1211', description: 'Chemistry I', hours: 4, course_groups: [course_group_lab_sciences])
course_chem1212 = safe_create Course.new(id: 20, name: 'CHEM 1212', description: 'Chemistry II', hours: 4, course_groups: [course_group_lab_sciences])
course_eas1600 = safe_create Course.new(id: 21, name: 'EAS 1600', description: 'Earth and Atmospheric Sciences I', hours: 4, course_groups: [course_group_lab_sciences])
course_eas1601 = safe_create Course.new(id: 22, name: 'EAS 1601', description: 'Earth and Atmospheric Sciences II', hours: 4, course_groups: [course_group_lab_sciences])
course_cs1301 = safe_create Course.new(id: 23, name: 'CS 1301', description: 'Introduction to Computing and Programming', hours: 3)
course_cs1331 = safe_create Course.new(id: 24, name: 'CS 1331', description: 'Introduction to Object-Oriented Programming', hours: 3)
course_cs1332 = safe_create Course.new(id: 25, name: 'CS 1332', description: 'Data Structures and Algorithms', hours: 3)
course_cs2050 = safe_create Course.new(id: 26, name: 'CS 2050', description: 'Introduction to Discrete Math', hours: 3)
course_cs2110 = safe_create Course.new(id: 27, name: 'CS 2110', description: 'Computing Organization and Programming', hours: 4)
course_cs2200 = safe_create Course.new(id: 28, name: 'CS 2200', description: 'Computer Systems and Networks', hours: 4)
course_cs2340 = safe_create Course.new(id: 29, name: 'CS 2340', description: 'Objects and Design', hours: 3)
course_cs3510 = safe_create Course.new(id: 32, name: 'CS 3510', description: 'Design and Analysis of Algorithms', hours: 3)
course_cs3210 = safe_create Course.new(id: 30, name: 'CS 3210', description: 'Design of Operating Systems', hours: 3)
course_cs3220 = safe_create Course.new(id: 31, name: 'CS 3220', description: 'Processor Design', hours: 3)
course_cs3251 = safe_create Course.new(id: 33, name: 'CS 3251', description: 'Networking I', hours: 3, course_groups: [course_group_info_management])
course_cs4235 = safe_create Course.new(id: 34, name: 'CS 4235', description: 'Introduction to Information Security', hours: 3, course_groups: [course_group_info_management])
course_cs4400 = safe_create Course.new(id: 35, name: 'CS 4400', description: 'Introduction to Database Systems', hours: 3, course_groups: [course_group_info_management])

# Prereqs
prereq_eng1102 = safe_create Prereq.new(id: 0, op: 'and', courses: [course_eng1101])
course_eng1102.update_attribute :prereq_id, prereq_eng1102.id
prereq_germ2002 = safe_create Prereq.new(id: 1, op: 'and', courses: [course_germ2001])
course_germ2002.update_attribute :prereq_id, prereq_germ2002.id
prereq_span2002 = safe_create Prereq.new(id: 2, op: 'and', courses: [course_span2001])
course_span2002.update_attribute :prereq_id, prereq_span2002.id
prereq_phys2212= safe_create Prereq.new(id: 3, op: 'and', courses: [course_phys2211])
course_phys2212.update_attribute :prereq_id, prereq_phys2212.id
prereq_chem1212 = safe_create Prereq.new(id: 4, op: 'and', courses: [course_chem1211])
course_chem1212.update_attribute :prereq_id, prereq_chem1212.id
prereq_eas1601 = safe_create Prereq.new(id: 5, op: 'and', courses: [course_eas1600])
course_eas1601.update_attribute :prereq_id, prereq_eas1601.id
prereq_cs1331 = safe_create Prereq.new(id:6, op:'and', courses: [course_cs1301])
course_cs1331.update_attribute :prereq_id, prereq_cs1331.id
prereq_cs1332 = safe_create Prereq.new(id: 7, op: 'and', courses: [course_cs1331])
course_cs1332.update_attribute :prereq_id, prereq_cs1332.id
prereq_cs2340 = safe_create Prereq.new(id: 8, op: 'and', courses: [course_cs1331])
course_cs2340.update_attribute :prereq_id, prereq_cs2340.id
prereq_cs2110 = safe_create Prereq.new(id: 9, op: 'and', courses: [course_cs1331])
course_cs2110.update_attribute :prereq_id, prereq_cs2110.id
prereq_cs2200 = safe_create Prereq.new(id: 10, op: 'and', courses: [course_cs2110])
course_cs2200.update_attribute :prereq_id, prereq_cs2200.id
prereq_cs3210 = safe_create Prereq.new(id: 11, op:'and', courses: [course_cs2200])
course_cs3210.update_attribute :prereq_id, prereq_cs3210.id
prereq_cs3220 = safe_create Prereq.new(id: 12, op:'and', courses: [course_cs2200])
course_cs3220.update_attribute :prereq_id, prereq_cs3220.id
prereq_cs3510_1 = safe_create Prereq.new(id: 13, op:'and', courses: [course_cs2050])
prereq_cs3510_2 = safe_create Prereq.new(id: 14, parent_id: prereq_cs3510_1.id, op:'or', courses: [course_cs1332, course_math3012])
course_cs3510.update_attribute :prereq_id, prereq_cs3510_1.id
prereq_cs3251 = safe_create Prereq.new(id: 15, op: 'and', courses: [course_cs2200])
course_cs3251.update_attribute :prereq_id, prereq_cs3251.id
prereq_cs4235 = safe_create Prereq.new(id: 16, op: 'and', courses: [course_cs2200])
course_cs4235.update_attribute :prereq_id, prereq_cs4235.id
prereq_cs4400 = safe_create Prereq.new(id: 17, op: 'and', courses: [course_cs1301])
course_cs4400.update_attribute :prereq_id, prereq_cs4400.id
prereq_math3012 = safe_create Prereq.new(id: 18, op: 'and', courses: [course_math1552])
course_math3012.update_attribute :prereq_id, prereq_math3012.id


# Requirements and rules
# Humanities
req_humanities = safe_create Requirement.new(id: 0, majors: [major_cs], priority: 0, op: 'and')
rule_eng1101 = safe_create RequirementRule.new(id: 0, requirement: req_humanities, priority: 0, rule_type: 'course', course: course_eng1101) 
rule_eng1102 = safe_create RequirementRule.new(id: 1, requirement: req_humanities, priority: 1, rule_type: 'course', course: course_eng1102) 
rule_humanities_6hr = safe_create RequirementRule.new(id: 2, requirement: req_humanities, priority: 2, rule_type: 'hours', quantity: 6, course_group: course_group_humanities)

# Lab sciences
req_lab_sciences = safe_create Requirement.new(id: 2, majors: [major_cs], priority: 2, op: 'and')
rule_phys2211 = safe_create RequirementRule.new(id: 3, requirement: req_lab_sciences, priority: 0, rule_type: 'course', course: course_phys2211)
req_additional_lab_sciences = safe_create Requirement.new(id: 3, parent_id: req_lab_sciences.id, priority: 1, op: 'or')
req_phys2212 = safe_create Requirement.new(id: 4, parent_id: req_additional_lab_sciences.id, priority: 0, op: 'and')
rule_phys2212 = safe_create RequirementRule.new(id: 4, requirement: req_phys2212, priority: 0, rule_type: 'course', course: course_phys2212)
rule_lab_sciences_1course = safe_create RequirementRule.new(id: 5, requirement: req_phys2212, priority: 1, rule_type: 'courses', quantity: 1, course_group: course_group_lab_sciences)
req_chem = safe_create Requirement.new(id: 5, parent_id: req_additional_lab_sciences.id, priority: 1, op: 'and')
rule_chem1211 = safe_create RequirementRule.new(id: 6, requirement: req_chem, priority: 0, rule_type: 'course', course: course_chem1211)
rule_chem1212 = safe_create RequirementRule.new(id: 7, requirement: req_chem, priority: 1, rule_type: 'course', course: course_chem1212)
req_eas = safe_create Requirement.new(id: 6, parent_id: req_additional_lab_sciences.id, priority: 2, op: 'and')
rule_eas1600 = safe_create RequirementRule.new(id: 8, requirement: req_eas, priority: 0, rule_type: 'course', course: course_eas1600)
rule_eas1601 = safe_create RequirementRule.new(id: 9, requirement: req_eas, priority: 1, rule_type: 'course', course: course_eas1601)

# Mathematics
req_math1551 = safe_create Requirement.new(id: 7, majors: [major_cs], priority: 3, op: 'and')
rule_math1551 = safe_create RequirementRule.new(id: 10, requirement: req_math1551, priority: 0, rule_type: 'course', course: course_math1551)
req_math1552 = safe_create Requirement.new(id: 8, majors: [major_cs], priority: 4, op: 'and')
rule_math1552 = safe_create RequirementRule.new(id: 11, requirement: req_math1552, priority: 0, rule_type: 'course', course: course_math1552)
req_math1554 = safe_create Requirement.new(id: 9, majors: [major_cs], priority: 5, op: 'and')
rule_math1554 = safe_create RequirementRule.new(id: 12, requirement: req_math1554, priority: 0, rule_type: 'course', course: course_math1554)
req_math2550 = safe_create Requirement.new(id: 10, majors: [major_cs], priority: 6, op: 'and')
rule_math2550 = safe_create RequirementRule.new(id: 13, requirement: req_math2550, priority: 0, rule_type: 'course', course: course_math2550)
req_math3012 = safe_create Requirement.new(id: 11, majors: [major_cs], priority: 7, op: 'and')
rule_math3012 = safe_create RequirementRule.new(id: 14, requirement: req_math3012, priority: 0, rule_type: 'course', course: course_math3012)
req_stat = safe_create Requirement.new(id: 12, majors: [major_cs], priority: 8, op: 'or')
rule_math3670 = safe_create RequirementRule.new(id: 15, requirement: req_stat, priority: 0, rule_type: 'course', course: course_math3670)
rule_isye3770 = safe_create RequirementRule.new(id: 16, requirement: req_stat, priority: 1, rule_type: 'course', course: course_isye3770)
req_isye_stat = safe_create Requirement.new(id: 13, parent_id: req_stat.id, priority: 2, op: 'and')
rule_isye2027 = safe_create RequirementRule.new(id: 17, requirement: req_isye_stat, priority: 0, rule_type: 'course', course: course_isye2027)
rule_isye2028 = safe_create RequirementRule.new(id: 18, requirement: req_isye_stat, priority: 1, rule_type: 'course', course: course_isye2028)


















