class MajorController < ApplicationController
  def show
    majors = Major.all
    render json: majors.as_json(include: [:tracks])
  end

  def update
    major_ids = params[:_json].collect { |major_data| major_data[:id] }
    majors = Major.find major_ids
    current_user.majors.destroy_all
    current_user.majors << majors

    render json: { message: 'successfully added majors' }
  end
end
