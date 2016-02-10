class MinorController < ApplicationController
  def get_all
    minors = Minor.all
    render json: minors
  end
end
