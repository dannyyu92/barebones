require 'rails/generators/rails/app/app_generator'

module Barebones
  class AppGenerator < Rails::Generators::AppGenerator

    class_option :skip_bundle, type: :boolean, aliases: "-B", default: true,
      desc: "Don't run bundle install"
      
    class_option :with_api, type: :boolean, default: true, 
      desc: "Add an API"

    def customizations
      say "Invoking customizations..."
      invoke :setup_ruby
      invoke :setup_routes
      invoke :setup_api
      invoke :setup_secrets
      invoke :setup_environments
    end

    def setup_ruby
      say "Setting ruby version..."
      build :set_ruby_version
    end

    def setup_routes
      say "Customizing routes..."
      build :customize_routes
    end

    def setup_api
      if options[:with_api]
        say "Setting up an API..."
        build :setup_oj
        build :create_api_constraints
        build :create_api_v1_defaults
        build :create_api_configurations
        build :create_api_layouts
      end
    end

    def setup_secrets
      say "Setting up secrets..."
      build :customize_secrets
    end

    def setup_environments
      say "Setting up environments..."
      invoke :setup_development_environment
      invoke :setup_staging_environment
      invoke :setup_production_environment
    end

    def setup_development_environment
      build :raise_on_delivery_errors
    end

    def setup_staging_environment
      build :create_staging_environment
    end

    def setup_production_environment
    end

    def outro
      say "\e[34mSweet, we're done!\e[0m"
    end

    protected

    # Supply Thor with template root path
    def self.source_root
      File.expand_path("../../../templates", File.dirname(__FILE__))
    end

    # Fall back to Rails default templates
    def self.source_paths
      paths = super
      paths << Rails::Generators::AppGenerator.source_root
    end

    # Look for custom builder class
    def get_builder_class
      Barebones::AppBuilder
    end
    
  end
end