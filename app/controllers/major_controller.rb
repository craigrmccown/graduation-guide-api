class MajorController < ApplicationController
  def get_all
    majors = Major.all
    render json: majors.as_json(include: [:tracks])
  end
end
