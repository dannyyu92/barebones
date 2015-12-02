module ApiDefaults
 extend ActiveSupport::Concern

 # Default Paths
 API_VIEW_PATH = "api/v1"
 API_DEFAULT_SUCCESS_PATH = "defaults/success"
 API_DEFAULT_FAIL_PATH = "defaults/fail"

 # Statuses
 SUCCESS = 200
 INTERNAL_SERVER_ERROR = 500

  included do
    layout 'api/v1/application'

    def render_api_success(path=ApiDefaults::API_DEFAULT_SUCCESS_PATH)
      @status = ApiDefaults::SUCCESS
      return render template: "#{API_VIEW_PATH}/#{path}", status: ApiDefaults::SUCCESS
    end

    def render_api_fail(path=ApiDefaults::API_DEFAULT_FAIL_PATH)
      @status = ApiDefaults::INTERNAL_SERVER_ERROR
      return render template: "#{API_VIEW_PATH}/#{path}", status: ApiDefaults::INTERNAL_SERVER_ERROR
    end
  end

end