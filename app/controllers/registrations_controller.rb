class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    result = ::Creators::UserCreator.call(user_params)
    @user = result.record

    if result.success?
      login(@user)
      redirect_to root_path, notice: I18n.t("controllers.registrations.user_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
