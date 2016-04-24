class RequirementController < ApplicationController
  def show
    requirements = current_user.requirement_tree
    render json: requirements
  end
end
