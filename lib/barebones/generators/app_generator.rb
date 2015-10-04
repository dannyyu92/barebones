require 'rails/generators/rails/app/app_generator'

module Barebones
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :skip_bundle, type: :boolean, aliases: "-B", default: true,
      desc: "Don't run bundle install"

    def customizations
      invoke :setup_ruby
      invoke :setup_routes
      invoke :setup_api
      invoke :setup_secrets
      invoke :setup_environments
    end

    def setup_ruby
      build :set_ruby_version
    end

    def setup_routes
      build :customize_routes
    end

    def setup_api
      build :setup_oj
      build :create_api_constraints
      build :create_api_v1_defaults
      build :create_api_configurations
      build :create_api_layouts
    end

    def setup_secrets
      build :customize_secrets
    end

    def setup_environments
      build :create_staging_environment
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