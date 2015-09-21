module Barebones
  class AppBuilder < Rails::AppBuilder

    # Overrides
    def readme
      template "README.md.erb", "README.md"
    end

    def gemfile
      template "Gemfile.erb", "Gemfile"
    end

    def gitignore
      super
    end

    def app
      super
      keep_file "app/services"
      keep_file "app/decorators"
      keep_file "app/workers"
    end

    def config
      super
    end

    def database_yml
      super
    end

    # Custom
    def set_ruby_version
      create_file ".ruby-version", "#{Barebones::RUBY_VERSION}"
    end

  end
end