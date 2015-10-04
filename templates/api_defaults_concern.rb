module ApiDefaults
 extend ActiveSupport::Concern

 # Default Paths
 API_VIEW_PATH = "api/v1"
 API_DEFAULT_SUCCESS_PATH = "defaults/success"
 API_DEFAULT_FAIL_PATH = "defaults/fail"

 # Statuses
 SUCCESS_STATUS = "success"
 FAIL_STATUS = "fail"

  included do
    layout 'api/v1/application'

    def render_api_success(path=ApiDefaults::API_DEFAULT_SUCCESS_PATH)
      @status = ApiDefaults::SUCCESS_STATUS
      return render template: "#{API_VIEW_PATH}/#{path}"
    end

    def render_api_fail(path=ApiDefaults::API_DEFAULT_FAIL_PATH)
      @status = ApiDefaults::FAIL_STATUS
      return render template: "#{API_VIEW_PATH}/#{path}"
    end
  end

end