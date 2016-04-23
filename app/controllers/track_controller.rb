class TrackController < ApplicationController
  def show
    tracks = Major.find(params[:id]).tracks
    render json: tracks
  end

  def add_tracks
    track_ids = params[:_json].collect { |track_data| track_data[:id] }
    user_track_ids = Tracks.get_by_major(current_user.majors).collect { |track| track.id }
    track_ids = user_track_ids & track_ids
    tracks = Track.find track_ids
    
    if tracks.length.eql? track_ids.length
      current_user.tracks.destroy_all
      current_user.tracks << tracks

      render json: { message: 'successfully added tracks' }
    else
      render json: { message: 'only tracks part of your selected majors allowed' }, status: 400
    end
  end
end
