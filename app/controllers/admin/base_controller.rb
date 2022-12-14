class Admin::BaseController < ApplicationController
  include Pagy::Backend
  before_action :require_admin

  private
    def require_admin
      render "/404" unless current_admin?
    end
end