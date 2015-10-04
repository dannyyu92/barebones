class Api::V1::ConfigsController < Api::V1::ApplicationController
  def ping
    @error_msg = "Test error message."
    @errors = ["TestError1", "TestError2"]
    return render_api_fail("configs/ping")
  end
end