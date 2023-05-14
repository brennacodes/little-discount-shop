class Auth::SessionsController < ApplicationController
  def new
    @user = User.find_by(username: params[:username]) || User.new
    session[:user] = @user
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.username}!"
      if @user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to user_dashboard_path
      end
    else
      render :new, alert: "Sorry, we were unable to log you in with those credentials."
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end