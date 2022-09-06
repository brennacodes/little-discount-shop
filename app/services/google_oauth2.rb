
#     client_id = YOUR_CLIENT_ID
#     client_secret = YOUR_CLIENT_SECRET
#     code = params[:code]
  
#     conn = Faraday.new(url: 'https://github.com', headers: {'Accept': 'application/json'})
  
#     conn = Faraday.new(
#       url: 'https://api.github.com',
#       headers: {
#           'Authorization': "token #{access_token}"
#       }
#     )
#     response = conn.get('/user')
#     data = JSON.parse(response.body, symbolize_names: true)

#     def index   
#       unless session.has_key?(:credentials)
#         redirect_to callback_path
#       end
#       client_opts = JSON.parse(session[:credentials])
#       auth_client = Signet::OAuth2::Client.new(client_opts)
#       drive = Google::Apis::DriveV2::DriveService.new
#       files = drive.list_files(options: { authorization: auth_client })
#       "<pre>#{JSON.pretty_generate(files.to_h)}</pre>"
#     end
  
#     def callback
#       client_secrets = Google::APIClient::ClientSecrets.load
#       auth_client = client_secrets.to_authorization
#       auth_client.update!(
#         :scope => 'https://www.googleapis.com/auth/drive.metadata.readonly',
#         :redirect_uri => url('/oauth2callback'))
#       if request['code'] == nil
#         auth_uri = auth_client.authorization_uri.to_s
#         redirect_to auth_uri
#       else
#         auth_client.code = request['code']
#         auth_client.fetch_access_token!
#         auth_client.client_secret = nil
#         session[:credentials] = auth_client.to_json
#         redirect_to dashboard_path
#       end
#     end

      
#   def create
#     auth_hash = request.env['omniauth.auth']
#     if auth_hash['credentials']['token'].present?
#       user = UserFacade.find_or_create_user(auth_hash[:info])
#       set_session(user)
#       redirect_to '/dashboard'
#     end
#   end

#   def destroy
#     session.clear
#     redirect_to root_path
#   end

#   private

#   def set_session(user)
#     session[:user_id] = user.id
#     session[:email] = user.email
#     session[:image] = user.image
#     session[:first_name] = user.name.split.first
#     session[:last_name] = user.name.split.last
#   end

# For AWS:
#   def ip_address
#     if Rails.env.production?
#       request.remote_ip
#     else
#       Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
#     end
#   end