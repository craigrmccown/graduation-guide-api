class MajorController < ApplicationController
  def get_all
    majors = Major.all
    render json: majors
  end
end
