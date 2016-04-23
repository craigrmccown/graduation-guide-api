class CourseGroupController < ApplicationController
  def show
    course_groups = CourseGroup.all
    render json: course_groups
  end
end
