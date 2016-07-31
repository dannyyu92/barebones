class Api::V1::ConfigsController < Api::V1::ApplicationController

  def ping
    return render_api(200, "configs/ping")
  end
  
end