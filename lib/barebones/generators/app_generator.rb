require 'rails/generators/rails/app/app_generator'

module Barebones
  class AppGenerator < Rails::Generators::AppGenerator
    
    def finish_template
      super
    end

    protected

    # Supply Thor with template root path
    def self.source_root
      File.expand_path("../../../templates", File.dirname(__FILE__))
    end

    # Look for custom builder class
    def get_builder_class
      Barebones::AppBuilder
    end
    
  end
end