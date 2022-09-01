class SessionsController < ApplicationController
  def new
    @user = User.find_by(email: params[:email]) || User.new
    session[:user] = @user
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end