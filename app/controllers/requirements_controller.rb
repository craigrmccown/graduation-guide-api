class RequirementsController
  def show
    requirements = Requirement.find_by_user current_user
    render json: requirements
  end
end
