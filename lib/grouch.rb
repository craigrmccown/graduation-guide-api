require "net/http"
require "json"

module Grouch
  @@grouch_endpoint = 'http://ec2-54-201-95-91.us-west-2.compute.amazonaws.com'

  def self.grouch_get(path)
    uri = URI("#{@@grouch_endpoint}/#{path}")
    response = Net::HTTP.get_response uri

    while response.code.eql? "301"
      response = Net::HTTP.get_response URI(response.header['location'])
    end

    if response.code.eql? "500"
      raise "500: #{path}"
    end

    JSON.parse response.body
  end

  def self.get_school_ids(semester_id="spring2016")
    data = grouch_get semester_id
    raise "Could not find key 'schools', path was #{semester_id}, data was #{data}" if data['schools'].nil?
    data['schools']
  end

  def self.get_course_ids(school_id, semester_id="spring2016")
    path = "#{semester_id}/#{school_id}"
    data = grouch_get path
    raise "Could not find key 'numbers', path was #{path}, data was #{data}" if data['numbers'].nil?
    data['numbers'].collect { |number| number.to_i }
  end

  def self.get_course(school_id, course_id, semester_id="spring2016") 
    grouch_get "#{semester_id}/#{school_id}/#{course_id}"
  end
end
