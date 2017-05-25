require 'rails/generators/rails/app/app_generator'

module Barebones
  class AppGenerator < Rails::Generators::AppGenerator

    class_option :skip_bundle, type: :boolean, aliases: "-B", default: true,
      desc: "Don't run bundle install"

    class_option :skip_api, type: :boolean, default: false, 
      desc: "Skip creating an API. Default is false."

    class_option :skip_resque, type: :boolean, default: true,
      desc: "Skip using Resque. Default is true."

    class_option :skip_sidekiq, type: :boolean, default: false, 
      desc: "Skip using Sidekiq. Default is false."

    class_option :skip_minitest, type: :boolean, default: false,
      desc: "Skip using Minitest. Default is false."

    class_option :skip_factory_girl, type: :boolean, default: false,
      desc: "Skip using Factory Girl. Default is false."

    class_option :skip_carrierwave, type: :boolean, default: false,
      desc: "Skip using Carrierwave. Default is false."

    def customizations
      say "Invoking customizations..."
      invoke :setup_ruby
      invoke :configure_app
      invoke :setup_routes
      invoke :setup_api
      invoke :setup_secrets
      invoke :setup_environments
      invoke :setup_gems
      invoke :outro
    end

    def setup_ruby
      say "Setting ruby version..."
      build :set_ruby_version
      build :set_gemset
    end

    def setup_routes
      say "Setting up custom routes..."
      build :customize_routes
    end

    def configure_app
      say "Configuring application..."
      build :setup_autoload_paths
    end

    def setup_api
      unless options[:skip_api]
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

    def setup_gems
      invoke :setup_minitest
      invoke :setup_factory_girl
      invoke :setup_resque
      invoke :setup_sidekiq
      invoke :setup_carrierwave
    end

    def setup_factory_girl
      unless options[:skip_factory_girl]
        say "Setting up FactoryGirl gem..."
        build :configure_factory_girl
      end
    end

    def setup_minitest
      unless options[:skip_minitest]
        say "Setting up Minitest gem..."
        build :configure_minitest
      end
    end

    def setup_resque
      unless options[:skip_resque]
        say "Setting up Resque/Redis gems..."
        build :configure_active_job_for_resque
        build :configure_redis
        build :configure_resque
        build :create_test_job
        build :create_resque_rake_task
      end
    end

    def setup_sidekiq
      unless options[:skip_sidekiq]
        say "Setting up Sidekiq/Redis gems..."
        build :configure_active_job_for_sidekiq
        build :configure_redis
        build :configure_sidekiq
        build :create_test_job
      end
    end

    def setup_carrierwave
      unless options[:setup_carrierwave]
        say "Setting up Carrierwave gem..."
        build :configure_carrierwave
      end
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

    # Custom
    def str_to_class(klass_str)
      klass_str.gsub(/\s/,"_").camelize(:upper)
    end
    
  end
end