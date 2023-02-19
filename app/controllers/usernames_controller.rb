class UsernamesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :redirect_to_username

  def new
  end

  def update
    if username_params[:username].present? and current_user.update(username_params)
      flash[:notice] = "Username successfully updated!"
      redirect_to dashboard_path
    else
      flash[:alert] =  if username_params[:username].blank?
                          "Please set a username"
                        else
                          current_user.errors.full_messages
                        end
      redirect_to new_username_path
    end
  end

  private
  def username_params
    params.require(:user).permit(:username)
  end
end