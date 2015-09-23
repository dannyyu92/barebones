module Barebones
  class AppBuilder < Rails::AppBuilder
    include Barebones::TextFormatHelpers

    # Overrides
    def readme
      template "README.md.erb", "README.md"
    end

    def gemfile
      template "Gemfile.erb", "Gemfile"
    end

    def gitignore
      template "barebones_gitignore", ".gitignore"
    end

    def app
      super
      keep_file "app/services"
      keep_file "app/decorators"
      keep_file "app/workers"
    end

    def config
      empty_directory "config"

      inside "config" do
        template "routes.rb"
        template "application.rb"
        customize_application_rb

        template "environment.rb"
        template "secrets.yml"

        directory "environments"
        directory "initializers"
        directory "locales"
      end
    end

    def database_yml
      super
    end

    # Custom
    def set_ruby_version
      create_file ".ruby-version", "#{Barebones::RUBY_VERSION}"
    end

    def customize_application_rb
      inject_into_file "application.rb", 
        after: "config.active_record.raise_in_transactional_callbacks = true\n" do
          "\n#{spaces(4)}# Autoload 'lib' folder\n"\
          "#{spaces(4)}config.autoload_paths << Rails.root.join('lib')\n"
      end
    end

  end
end