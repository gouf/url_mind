class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||=
      session[:current_user_login] && ENV['USER_EMAIL']
  end
end
