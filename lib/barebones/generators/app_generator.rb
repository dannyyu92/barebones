require 'rails/generators/rails/app/app_generator'

module Barebones
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :skip_bundle, type: :boolean, aliases: "-B", default: true,
      desc: "Don't run bundle install"

    def customizations
      invoke :setup_gemfile
      #invoke :setup_environments
    end

    def setup_gemfile
      build :set_ruby_version
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