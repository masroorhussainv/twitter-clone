class UsernamesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :redirect_to_username

  def new

  end

  def update
    current_user.update(username_params)
    redirect_to dashboard_path
  end

  private
  def username_params
    params.require(:user).permit(:username)
  end
end