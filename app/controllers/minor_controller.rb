class MinorController < ApplicationController
  def show
    minors = Minor.all
    render json: minors
  end

  def update
    minor_ids = params[:_json].collect { |minor_data| minor_data[:id] }
    minors = Minor.find minor_ids
    current_user.minors.destroy_all
    current_user.minors << minors

    render json: { message: 'successfully added minors' }
  end
end
