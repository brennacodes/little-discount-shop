class SessionsController < ApplicationController
  def new
    @user = User.find_by(username: params[:username]) || User.new
    session[:user] = @user
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to admin_dashboard_path, notice: "Welcome, #{@user.username}!"
    else
      render :new, alert: "Sorry, your credentials are bad."
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end