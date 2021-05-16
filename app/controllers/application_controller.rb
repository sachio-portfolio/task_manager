class ApplicationController < ActionController::Base
  before_action :basic if Rails.env.production?
  before_action :login_required
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def basic
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
  def login_required
    redirect_to new_session_path unless current_user
  end
end
