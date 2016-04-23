class CourseController < ApplicationController
  def show
    courses = required_courses
    prereqs = Prereq.build_tree courses

    render json: { courses: required_courses, prereqs: prereqs }
  end

  def show_completed
    render json: current_user.courses
  end

  def update_completed
    course_ids = params[:_json].collect { |course_data| course_data[:id] }
    user_course_ids = required_courses.collect { |course| course.id }
    course_ids = user_course_ids & course_ids
    courses = Course.find course_ids

    if courses.length.eql? course_ids.length
      current_user.courses.destroy_all
      current_user.courses << courses

      render json: { message: 'successfully added courses' }
    else
      render json: { message: 'only courses part of your selected majors, minors, and tracks allowed' }, status: 400
    end
  end

  def required_courses
    major_courses | minor_courses | track_courses
  end

  def major_courses
    major_courses = (current_user.majors.collect { |major| major.courses }).flatten
  end

  def track_courses
    track_courses = (current_user.tracks.collect { |track| track.courses }).flatten
  end

  def minor_courses
    minor_courses = (current_user.minors.collect { |minor| minor.courses }).flatten
  end
end
