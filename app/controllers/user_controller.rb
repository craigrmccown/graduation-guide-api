class UserController < ApplicationController
  include ParamsSupport

  skip_before_action :authenticate!, only: [:register_student]
  before_action only: [:register_student] { required :password }
  before_action only: [:register_student] { permit :email, :first_name, :last_name }

  def register_student
    user = User.new @user_data
    user.password = params[:password]
    user.create_student!
    render json: { message: 'successfully registered student' }
  end

  def whoami
    render json: current_user
  end

  def add_majors
    major_ids = params[:_json].collect { |major_data| major_data[:id] } 
    majors = Major.find major_ids
    current_user.majors.destroy_all
    current_user.majors << majors
    render json: { message: 'successfully added majors' }
  end

  def add_minors
    minor_ids = params[:_json].collect { |minor_data| minor_data[:id] }
    minors = Minor.find minor_ids
    current_user.minors.destroy_all
    current_user.minors << minors
    render json: { message: 'successfully added minors' }
  end

  def add_tracks
    track_ids = params[:_json].collect { |track_data| track_data[:id] }
    major_track_ids = Tracks.get_by_major(current_user.majors).collect { |track| track.id }
    track_ids = major_track_ids & track_ids
    tracks = Track.find track_ids
    
    if tracks.length.eql? track_ids.length
      current_user.tracks.destroy_all
      current_user.tracks << tracks
      render json: { message: 'successfully added tracks' }
    else
      render json: { message: 'only tracks part of your selected majors allowed' }, status: 400
  end

  def add_courses
    course_ids = params[:_json].collect { |course_data| course_data[:id] }
    courses = Course.find course_ids
    current_user.courses.destroy_all
    current_user.courses << courses
    render json: { message: 'successfully added courses' }
  end
end
