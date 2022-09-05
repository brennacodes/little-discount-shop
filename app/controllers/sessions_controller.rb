class SessionsController < ApplicationController
  def new
    @user = User.find_by(username: params[:username]) || User.new
    session[:user] = @user
    redirect_to "http://localhost:3000/auth/google_oauth2/callback"
  end

  def create
    client_id = YOUR_CLIENT_ID
    client_secret = YOUR_CLIENT_SECRET
    code = params[:code]
  
    conn = Faraday.new(url: 'https://github.com', headers: {'Accept': 'application/json'})
  
    conn = Faraday.new(
      url: 'https://api.github.com',
      headers: {
          'Authorization': "token #{access_token}"
      }
    )
    response = conn.get('/user')
    data = JSON.parse(response.body, symbolize_names: true)

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