class SessionsController < ApplicationController
  def new; end

  def create
    if User.authenticate_by(username: params[:username], password: params[:password])
      login User.find_by(username: params[:username])
      redirect_to root_path, notice: I18n.t("controllers.sessions.user_login")
    else
      flash[:alert] = I18n.t("controllers.sessions.user_login_failed")
      render :new, status: :unauthorized
    end
  end

  def destroy
    logout current_user
    redirect_to root_path, notice: I18n.t("controllers.sessions.user_logout")
  end
end
