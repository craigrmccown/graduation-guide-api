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
    request_body = [] unless params[:_json]
    major_ids = request_body.map { |major_data| major_data[:id] } 
    majors = Major.find major_ids
    current_user.majors.destroy_all
    current_user.majors << majors
    current_user.save!
    render json: { message: 'successfully added majors' }
  end

  def add_minors
    request_body = [] unless params[:_json]
    minor_ids = request_body.map { |minor_data| minor_data[:id] }
    minors = Minor.find minor_ids
    current_user.minors.destroy_all
    current_user.minors << minors
    current_user.save!
    render json: { message: 'successfully added minors' }
  end

  def add_tracks
    # TODO enforce only adding tracks from current majors
    request_body = [] unless params[:_json]
    track_ids = request_body.map { |track_data| track_data[:id] }
    tracks = Track.find track_ids
    current_user.tracks.destroy_all
    current_user.tracks << tracks
    current_user.save!
    render json: { message: 'successfully added tracks' }
  end
end
