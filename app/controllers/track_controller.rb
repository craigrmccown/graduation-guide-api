class TrackController < ApplicationController
  def get_by_major
    tracks = Major.find(params[:id]).tracks
    render json: tracks
  end
end
