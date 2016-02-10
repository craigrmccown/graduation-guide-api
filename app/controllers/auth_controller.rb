class AuthController < ApplicationController
  include ParamsSupport

  skip_before_action :authenticate!
  before_action only: [:login] { required :email, :password }
  
  def login
    user = User.find_by email: params[:email]
    verify_password user, params[:password]

    cookies.encrypted[:auth_token] = {
      value: { id: user.id },
      expires: 1.day.from_now
    }

    render json: { message: 'login success' }
  end

  def logout
    cookies.encrypted[:auth_token] = nil
    render json: { message: 'successfully logged out' }
  end

  private

  def verify_password(user, password)
    if user.nil? or !user.has_matching_password? params[:password]
      raise UnauthorizedError, 'login failure'
    end
  end
end
