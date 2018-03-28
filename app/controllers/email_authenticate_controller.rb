class EmailAuthenticateController < ApplicationController
  before_action :current_user, only: %i[index]

  def index
    redirect_to read_laters_path and return if @current_user
  end

  def create
    redirect_to _path =
      if params[:email].eql?(ENV['USER_EMAIL'])
        session[:current_user_login] = true
        read_laters_path
      else
        login_path
      end
  end

  def destroy
    session[:current_user_login] = nil
    redirect_to login_path
  end
end
