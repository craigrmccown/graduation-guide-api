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

    JSON.parse response.body
  end

  def self.get_major_ids(semester_id="spring2016")
    data = grouch_get semester_id
    data['schools']
  end

  def self.get_course_ids(major_id, semester_id="spring2016")
    data = grouch_get "#{semester_id}/#{major_id}"
    data['numbers'].collect { |number| number.to_i }
  end

  def self.get_course(major_id, course_id, semester_id="spring2016") 
    grouch_get "#{semester_id}/#{major_id}/#{course_id}"
  end
end
