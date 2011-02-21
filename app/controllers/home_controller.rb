class HomeController < ApplicationController
  def index
    @app_config = APP_CONFIG
  end
end
