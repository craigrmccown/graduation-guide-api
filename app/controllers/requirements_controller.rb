class RequirementsController
  def show
    requirements = Requirement.find_by_user current_user
    courses = Course.all

    requirements.each do |requirement|
      requirement.load! courses
    end

    current_user.courses.each do |course|
      requirements.each do |requirement|
        break if requirement.evaluate! course
      end
    end

    render json: requirements
  end
end
