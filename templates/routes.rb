Rails.application.routes.draw do
  
  root 'welcome#index'

  # API
  constraints subdomain: (/(dev){0,1}api/) do
    namespace :api, path: "/", defaults: { format: "json" } do
      scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

        # Configurations
        get "ping" => "configs#ping"
        
      end
    end
  end

end