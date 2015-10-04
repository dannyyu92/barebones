class Api::V1::ConfigsController < Api::V1::ApplicationController
  def ping
    return render_api_success("configs/ping")
  end
end