require 'grouchseed.rb' 

def get_prereqs_list(major="CS", course) 
    course_info = get_course_info(major, course, $current_semester)
    prereqs = course_info.prerequisites
end

def get_postreqs_list(major="CS", course)
    course_info = get_course_info(major, course, $current_semester)
    return course_info.required_by
end

def current_semester()
    current_year = Date.today.year
    fall_sched_avail = Date.new(year=current_year, 3, 9).past?
    spring_sched_avail = Date.new(year=current_year, 10, 15).past?
    sched_season = "spring" if spring_sched_avail or not fall_sched_avail else "fall"
    sched_year = current_year + 1 if spring_sched_avail else current_year
    return sched_season + sched_year
