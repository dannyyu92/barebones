require 'rails/generators/rails/app/app_generator'

module Barebones
  class AppGenerator < Rails::Generators::AppGenerator

    class_option :skip_bundle, type: :boolean, aliases: "-B", default: true,
      desc: "Don't run bundle install"

    class_option :skip_api, type: :boolean, default: false, 
      desc: "Skip creating an API. Default is false."

    class_option :skip_resque, type: :boolean, default: false,
      desc: "Skip using Resque. Default is false."

    class_option :skip_sorcery, type: :boolean, default: false,
      desc: "Skip using Sorcery for user authentication. Default is false."

    class_option :skip_minitest, type: :boolean, default: false,
      desc: "Skip using Minitest. Default is false."

    class_option :skip_carrierwave, type: :boolean, default: false,
      desc: "Skip using Carrierwave. Default is false."

    def customizations
      say "Invoking customizations..."
      invoke :setup_ruby
      invoke :setup_api
      invoke :setup_secrets
      invoke :setup_environments
      invoke :setup_gems
      invoke :outro
    end

    def setup_ruby
      say "Setting ruby version..."
      build :set_ruby_version
    end

    def setup_api
      unless options[:skip_api]
        say "Setting up an API..."
        build :customize_routes
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
      #invoke :setup_sorcery
      invoke :setup_resque
      invoke :setup_carrierwave
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
        build :configure_active_job
        build :configure_redis
        build :configure_resque
        build :create_test_job
        build :create_resque_rake_task
      end
    end

    def setup_carrierwave
      unless options[:setup_carrierwave]
        say "Setting up Carrierwave gem..."
        build :configure_carrierwave
      end
    end

    def outro
      invoke :minitest_setup_reminder
      invoke :resque_web_reminder
      say "\e[34mSweet, we're done!\e[0m"
    end

    def minitest_setup_reminder
      unless options[:skip_minitest]
        say "==========================================\n"\
          "Remember to run `rails g minitest:install` \n"\
          "and to set up Minitest-Reporters!\n"\
          "==========================================\n"
      end
    end

    def resque_web_reminder
      unless options[:skip_resque]
        say "==============================================\n"\
          "If you'd like to have the resque-web dashboard, \n"\
          "you should add the following to your routes: \n"\
          "`require 'resque/scheduler/server'`\n"\
          "`mount Resque::Server.new, :at => '/resque'`\n"\
          "==============================================\n"
      end
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