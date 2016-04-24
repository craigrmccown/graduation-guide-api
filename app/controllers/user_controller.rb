class UserController < ApplicationController
  include ParamsSupport

  skip_before_action :authenticate!, only: [:new]
  before_action only: [:new] { required :password }
  before_action only: [:new] { permit :email, :first_name, :last_name }

  def new
    user = User.new @user_data
    user.password = params[:password]
    user.create_student!
    render json: { message: 'successfully registered student' }
  end

  def show
    render json: current_user
  end
end
