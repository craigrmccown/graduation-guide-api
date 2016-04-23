class TrackController < ApplicationController
  def show
    tracks = Major.find(params[:id]).tracks
    render json: tracks
  end

  def add_tracks
    track_ids = params[:_json].collect { |track_data| track_data[:id] }
    tracks = Track.find track_ids
    current_user.tracks.destroy_all
    current_user.tracks << tracks

    render json: { message: 'successfully added tracks' }
  end
end
