class UserController < ApplicationController
  include ParamsSupport

  skip_before_action :authenticate!, only: [:register_student]
  before_action only: [:register_student] { required :password }
  before_action only: [:register_student] { permit :email, :first_name, :last_name }

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
