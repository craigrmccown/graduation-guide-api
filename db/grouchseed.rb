require "net/http"
require "uri"
require "json"
$grouch_endpoint = 'http://ec2-54-201-95-91.us-west-2.compute.amazonaws.com'

def create(model, data)
  if model.exists? data[:id]
    model.find data[:id]
  else
    model.create! data
  end
end

def get_majors(semester="spring2016")
    request = @uri = "/#{semester}"
    response = JSON.parse(Net:HTTP.get_response(request))
    return response
end

def get_courses(major="CS", semester="spring2016")
    request = @uri = "/#{semester}/#{major}"
    response = JSON.parse(Net:HTTP.get_response(request))
    return response
end

def get_course_info(major="CS", course, semester="spring2016")
    request = @uri + "/#{semester}/#{major}/#{courseNo}"
    response = JSON.parse(Net:HTTP.get_response(request))
    return response
end

@uri = URI.parse(grouch_endpoint)

i = 0

get_majors.each { |major|
  curr_major = create Major, id: i, name: major, description: ''
  curr_major.courses.destroy_all

  j = 0

  get_courses(major).each { |course|
    course_info = get_course_info(major, course)
    curr_course = create Course, id: j, name: course_info.identifier, description: course_info.name
    curr_major.courses << curr_course
    j += 1
  }

  i += 1

  curr_major.save!
}