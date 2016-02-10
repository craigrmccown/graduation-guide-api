class UserController < ApplicationController
  include ParamsSupport

  skip_before_action :authenticate!
  before_action only: [:register_student] { required :password }
  before_action only: [:register_student] { permit :email, :first_name, :last_name }

  def register_student
    user = User.new @user_data
    user.password = params[:password]
    user.create_student!
    render json: { message: 'successfully registered student' }
  end
end
