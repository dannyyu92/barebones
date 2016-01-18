module Barebones
  class AppBuilder < Rails::AppBuilder
    include Barebones::TextFormatHelpers

    # Overrides
    def readme
      template "README.md.erb", "README.md"
    end

    def gemfile
      template "Gemfile.erb", "Gemfile"
      replace_regex_in_file("Gemfile", /\n{2,}/, "\n\n")
    end

    def gitignore
      template "barebones_gitignore", ".gitignore"
    end

    def app
      super
      keep_file "app/services"
      keep_file "app/decorators"
      template  "barebones_decorator.rb.erb", 
        "app/decorators/#{app_name.parameterize.underscore}_decorator.rb"
      keep_file "app/workers"
    end

    def config
      super
    end

    def database_yml
      template "database.yml.erb", "config/database.yml"
    end

    # Custom
    def set_ruby_version
      create_file ".ruby-version", "#{Barebones::RUBY_VERSION}"
    end

    def customize_routes
      template "routes.rb.erb", "config/routes.rb", force: true
    end

    def setup_autoload_paths
      inject_into_file "config/application.rb", 
        after: "config.active_record.raise_in_transactional_callbacks = true\n" do
          "\n#{spaces(4)}# Autoload 'lib' folder\n"\
          "#{spaces(4)}config.autoload_paths << Rails.root.join('lib')\n"
      end
    end

    def setup_oj
      template "multi_json.rb", "config/initializers/multi_json.rb"
    end

    def create_api_constraints
      template "api_constraints.rb.erb", "lib/api_constraints.rb"
    end

    def create_api_v1_defaults
      empty_directory "app/controllers/api"
      empty_directory "app/controllers/api/v1"
      template "api_application_controller.rb", "app/controllers/api/v1/application_controller.rb"
      template "api_defaults_concern.rb", "app/controllers/concerns/api_defaults.rb"
    end

    def create_api_configurations
      empty_directory "app/views/api/v1/configs"
      template "configs_controller.rb", "app/controllers/api/v1/configs_controller.rb"
      template "config_ping.json.jbuilder", "app/views/api/v1/configs/ping.json.jbuilder"
    end

    def create_api_layouts
      empty_directory "app/views/layouts/api/v1"
      template "layout.json.jbuilder", "app/views/layouts/api/v1/application.json.jbuilder"
      empty_directory "app/views/api/defaults"
      create_file "app/views/api/defaults/success.json.jbuilder"
      create_file "app/views/api/defaults/fail.json.jbuilder"
    end

    def customize_secrets
      template "secrets.yml.erb", "config/secrets.yml", force: true
    end

    def raise_on_delivery_errors
      file = "config/environments/development.rb"
      gsub_file file, "config.action_mailer.raise_delivery_errors = false" do |match|
        "config.action_mailer.raise_delivery_errors = true"
      end
    end

    def create_staging_environment
      environment_path = "config/environments"
      run "cp #{environment_path}/development.rb #{environment_path}/staging.rb"
    end

    def setup_factory_girl
      class_end_line = "end\n"
      inject_into_file "test/test_helper.rb",
        after: class_end_line do
          "# Minitest does not provide a way to include or "\
          "extend a module into every test class\n"\
          "# without re-opening the test case class\n"\
          "module Minitest\n"\
          "#{spaces(2)}class Test\n"\
          "#{spaces(4)}include FactoryGirl::Syntax::Methods\n"\
          "#{spaces(2)}end\n"\
          "end\n"
      end
    end

    def configure_minitest
      autoload_paths_line = "config.autoload_paths << Rails.root.join('lib')\n"
      inject_into_file "config/application.rb", 
        after: autoload_paths_line do
          "\n#{spaces(4)}# Auto generate test files\n"\
          "#{spaces(4)}config.generators do |g|\n"\
          "#{spaces(6)}g.test_framework :minitest, spec: true, fixture: false\n"\
          "#{spaces(4)}end\n"
      end

      last_require = "require 'rails/test_help'\n"
      inject_into_file "test/test_helper.rb",
        after: last_require do
          "require 'minitest/reporters'\n"\
          "require 'minitest/spec'\n"\
          "require 'mocha/mini_test'\n"\
          "# Require all support helpers\n"\
          "Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }\n"\
          "Minitest::Reporters.use!(\n"\
          "#{spaces(2)}Minitest::Reporters::DefaultReporter.new,\n"\
          "#{spaces(2)}ENV,\n"\
          "#{spaces(2)}Minitest.backtrace_filter\n"\
          ")\n"
      end
        
    end    

    def configure_active_job
      autoload_paths_line = "config.autoload_paths << Rails.root.join('lib')\n"
      inject_into_file "config/application.rb", 
        after: autoload_paths_line do
          "\n#{spaces(4)}# Set ActiveJob to use Resque\n"\
          "#{spaces(4)}config.active_job.queue_adapter = :resque\n"
      end
    end

    def configure_redis
      template "redis.rb", "config/initializers/redis.rb"
    end

    def configure_resque
      template "resque.rb", "config/initializers/resque.rb"
    end

    def create_test_job
      template "test_job.rb", "app/workers/test_job.rb"
    end

    def create_resque_rake_task
      template "resque.rake", "lib/tasks/resque.rake"
    end

    def configure_carrierwave
      template "carrierwave.rb", "config/initializers/carrierwave.rb"
    end

  end
end