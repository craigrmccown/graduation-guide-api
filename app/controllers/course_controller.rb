class CourseController < ApplicationController
  def get_all_for_user
    major_courses = (current_user.majors.collect { |major| major.courses }).flatten
    minor_courses = (current_user.minors.collect { |minor| minor.courses }).flatten
    track_courses = (current_user.tracks.collect { |track| track.courses }).flatten
    courses = (major_courses + minor_courses + track_courses).uniq
    render json: courses
  end

  def get_major_courses
    major_courses = (current_user.majors.collect { |major| major.courses }).flatten
    render json: major_courses
  end

  def get_minor_courses
    minor_courses = (current_user.minors.collect { |minor| minor.courses }).flatten
    render json: minor_courses
  end

  def get_track_courses
    track_courses = (current_user.tracks.collect { |track| track.courses }).flatten
    render json: track_courses
  end
end
