class ApplicationController < ActionController::Base
  attr_accessor :current_user
  before_action :authenticate!
  skip_before_action :authenticate!, only: [:missing_endpoint]

  rescue_from StandardError do |e|
    render json: { message: ([e.class.name, e.message] + e.backtrace).join(',') }, status: :internal_server_error
  end

  rescue_from CanCan::AccessDenied do |e|
    render json: { message: 'you do not have sufficient roles to perform this action' }, status: :forbidden
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { message: e.message }, status: :bad_request
  end

  rescue_from UnauthorizedError do |e|
    render json: { message: e.message }, status: :unauthorized
  end

  rescue_from NotFoundError do |e|
    render json: { message: e.message }, status: :not_found
  end

  def missing_endpoint
    raise NotFoundError, 'the endpoint you are requesting does not exist'
  end

  def authenticate!
    authenticate_user!
    authorize_user!
  end

  def authenticate_user!
    auth_data = cookies.encrypted[:auth_token]
    raise UnauthorizedError, "you must be logged in to perform this action" if auth_data.nil?

    @current_user = User.find_by(id: auth_data['id'])
    raise UnauthorizedError, "logged in user does not exist" if current_user.nil?
  end

  def authorize_user!
    authorize! action_name.to_sym, controller_name.classify.constantize
  end
end
