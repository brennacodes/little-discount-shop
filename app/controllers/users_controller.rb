class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_dashboard_path
      flash[:success] = "Welcome, #{user.username}!"
    else
      redirect_to '/users/new'
      flash[:error] = user.errors.full_messages
    end
  end

  def login_form; end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if user.admin?
        redirect_to admin_dashboard_path
      elsif user.manager?
        redirect_to manager_dashboard_path
      elsif user.default?
        redirect_to user_dashboard_path
      end
      flash[:success] = "Welcome back, #{user.username}!"
    else
      flash[:error] = "Yikes. That didn't go as planned. Try again?"
      render :login_form
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end