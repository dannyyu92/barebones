module ApiDefaults
 extend ActiveSupport::Concern

 # Default Paths
 API_VIEW_PATH = "api/v1"
 API_DEFAULT_PATH = "defaults/default"

  included do
    layout 'api/v1/application'

    def render_api(status, path=ApiDefaults::API_DEFAULT_PATH)
      @status = status
      return render template: "#{API_VIEW_PATH}/#{path}", status: status
    end

  end

end