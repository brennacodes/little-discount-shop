class ApplicationController < ActionController::Base
  include Serializable
  include Statusable
  include Typable
  
  helper_method :current_user

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    json_response({ message: e.message }, :not_found)
  end
end
