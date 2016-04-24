class PrereqController < ApplicationController
  def show
    prereqs = current_user.prereq_tree
    render json: prereqs
  end
end
