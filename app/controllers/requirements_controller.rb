class RequirementsController
    require "net/http"
    require "uri"
    require "json"
    $grouch_endpoint = "http://ec2-54-201-95-91.us-west-2.compute.amazonaws.com"
    
    def initialize
        @uri = URI.parse(grouch_endpoint)
    end

    def get_prereqs(courseNo, major = "CS", semester = "spring2016")
        request = @uri + "/#{semester}/#{major}/#{courseNo}" # Format Grouch request
        
        response = JSON.parse(Net:HTTP.get_response(uri))

        return response.prerequisites
    end
end
