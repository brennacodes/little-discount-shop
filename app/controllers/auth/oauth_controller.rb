class Auth::OauthController < ApplicationController
  # def new   
  #   unless session.has_key?(:credentials)
  #     redirect_to login_path
  #   end
  #   client_opts = JSON.parse(session[:credentials])
  #   auth_client = Signet::OAuth2::Client.new(client_opts)
  #   drive = Google::Apis::DriveV2::DriveService.new
  #   files = drive.list_files(options: { authorization: auth_client })
  #   JSON.parse(files.to_json)
  # end

  # def callback
  #   client_secrets = Google::APIClient::ClientSecrets.load
  #   auth_client = client_secrets.to_authorization
  #   auth_client.update!(
  #     :scope => 'https://www.googleapis.com/auth/drive.metadata.readonly',
  #     :redirect_uri => url('/oauth2callback'))
  #   if request['code'] == nil
  #     auth_uri = auth_client.authorization_uri.to_s
  #     redirect_to auth_uri
  #   else
  #     auth_client.code = request['code']
  #     auth_client.fetch_access_token!
  #     auth_client.client_secret = nil
  #     session[:credentials] = auth_client.to_json
  #     redirect_to dashboard_path
  #   end
  # end
      
  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash['credentials']['token'].present?
      find_user
      redirect_to '/dashboard'
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private
    def find_user
      @user = User.find_or_create_by(email: auth_hash[:info][:email])
      if @user
        @user.username = data[:name]
        @user.uid      = data[:openid]
        @user.token    = access_token
        @user.save
        set_session(@user)
      else
        redirect_to login_path, notice: "Sorry, your we could not log you in."
      end
    end

    def set_session(user)
      session[:user_id] = user.id
      session[:email] = user.email
      session[:image] = user.image
      session[:first_name] = user.name.split.first
      session[:last_name] = user.name.split.last
    end
end
