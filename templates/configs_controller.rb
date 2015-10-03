class Api::V1::ConfigsController < Api::V1::ApplicationController
  def ping
    return render json: { "ping": "pong!" }
  end
end