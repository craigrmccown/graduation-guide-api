class CourseController < ApplicationController
  def show
    courses = Course.all
    render json: courses
  end

  def show_completed
    render json: current_user.courses
  end

  def update_completed
    course_ids = params[:_json].collect { |course_data| course_data[:id] }
    courses = Course.find course_ids
    current_user.courses.destroy_all
    current_user.courses << courses

    render json: { message: 'successfully added courses' }
  end
end
